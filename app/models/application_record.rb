class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  include DateTimeHelper

  belongs_to :updated_by, optional: true, class_name: 'User'
  belongs_to :created_by, optional: true, class_name: 'User'

  before_save do
    self.updated_by_id = User.current_user.id if self.class.column_names.include?('updated_by_id')
  end

  before_create do
    self.created_by_id = User.current_user.id if self.class.column_names.include?('created_by_id')
  end

  after_create do
    EmailWorker.perform_in(1.second, self.class.to_s, self.id)
  end

  after_update do
    if self.class.to_s != 'User'
      EmailUpdateWorker.perform_async(self.class.to_s, self.id)
      EmailWatcherWorker.perform_async( self.class.to_s, self.id)
    end
  end


  def email_notification_enabled?(type)
    notif = EmailNotification.find_by(email_type: type, name: "#{self.class}") || EmailNotification.new(status: false)
    notif.enabled?
  end

  def little_description
    output = ''
    output<< "<p> #{} </p>"
    output<< "<p> #{} </p>"
    output<< "<p> #{} </p>"

    output.html_safe
  end

  def self.available_variable
    ['user_name'] + model_variables
  end

  def self.model_variables
    self.new.method(:for_mail).source.scan(/#\{\w+\}/).map{|v| v.scan(/\w+/)}.flatten
  rescue
    []
  end

  def self.email_variables
    available_variable
  end

  def email_template(user)
    default_template = EmailTemplate.default(self.for_mail)
    convert_email(user, EmailTemplate.where(model: self.class.to_s).first || default_template )
  end

  def convert_email user, template
    template.header = generate_email(user, template.header)
    template.body = generate_email(user, template.body)
    template.footer = generate_email(user, template.footer)
    template
  end

  def generate_email user,  template
    variables = self.class.available_variable - ['user_name']
    template.gsub!('%{user_name}', user.try(:name))
    variables.each do |variable|
      r = self.send(variable) rescue ''
      result = if r.is_a?(Date) or r.is_a?(DateTime)
                 r.strftime("#{Setting['format_date']} %I:%M %p")
               else
                 r.to_s.html_safe
               end
      template.gsub!("%{#{variable}}", result)
    end
    template
  end


  scope :visible, -> { where(user_id: User.current.id) }

  def self.for_status(status)
    scope =  self.visible
    scope.filter_status status
  end

  def self.filter_status status
    case status
      when 'all' then all_data
      when 'opened' then opened
      when 'closed' then closed
      when 'flagged' then flagged
      else
        all_data
    end
  end

  def self.for_manager_status(status)
    scope =  User.current.can?(:manage_roles) ? self.where(assigned_to_id: User.current.id) : self.visible
    scope.filter_status status
  end

  def self.to_csv(data)
    attributes =  csv_attributes

    CSV.generate(headers: true) do |csv|
      csv << attributes

      data.each do |d|
        csv << d.map{|str| ActionView::Base.full_sanitizer.sanitize(str.to_s)}
      end
    end
  end

  def self.csv_attributes
    %w()
  end


  def can?(*args)
    User.current_user.admin? or User.current_user.can?(:manage_roles) or (owner? and args.map{|action| User.current.allowed_to? action }.include?(true) )
  end

  def owner?
    self.try(:user) == User.current
  end

  def humanize_value object, key, value
    if ['note', 'description'].include?(key)
      value.html_safe
    elsif key[-3..-1] == '_id'
      object.send(key[0..-4])
    else
      value
    end
  end

  # example:  Case.include_enumerations.join_enumeration(types)
  def self.join_enumeration(types, status, type = ' OR ')
    scope = self
    cond = ""
    cond_where = []
    cond_where2 = []
    types.each_with_index do |t, idx|
      enumeration_type = t[0]
      enumeration_column = t[1]
      cond<< " LEFT JOIN enumerations e#{idx} ON #{self.table_name}.#{enumeration_column} = e#{idx}.id AND e#{idx}.type = '#{enumeration_type}' "

      status.each do |k, v|
        cond_where << "e#{idx}.#{k} = ? "
        cond_where2 << v
      end
    end
    scope.joins(cond).where(cond_where.join(type), *cond_where2 )
  end

  def self.enumeration_columns
    fail(
        MethodNotImplementedError,
        'Please implement this method in your class.'
    )
  end

  def self.all_data
    # where.not(id: closed.pluck(:id))
    where(nil)
  end

  def self.opened
    # join_enumeration(enumeration_columns, { is_closed: false, is_flagged: false}, ' AND ', '!=')
    where.not(id: closed_or_flagged.pluck(:id))
  end

  def self.closed
    join_enumeration(enumeration_columns, { is_closed: true})
  end

  def self.flagged
    join_enumeration(enumeration_columns, { is_flagged: true})
  end

  def self.closed_or_flagged
    join_enumeration(enumeration_columns, { is_closed: true, is_flagged: true})
  end

  def can_send_email?
    false
  end
end
