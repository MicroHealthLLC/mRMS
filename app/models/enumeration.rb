class Enumeration < ActiveRecord::Base
  include SubclassFactory
  include ActAsPosition
  default_scope lambda {order('position ASC, name ASC')}

  before_destroy :check_integrity
  before_save    :check_default

  before_create :set_default_position
  after_save :update_position
  after_destroy :remove_position

  # attr_protected :type

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => [:type]
  validates_length_of :name, :maximum => 100

  scope :sorted, lambda { order(:position) }
  scope :active, lambda { where(:active => true) }
  scope :flagged, lambda { where(:is_flagged => true) }
  scope :closed, lambda { where(:is_closed => true) }

  scope :named, lambda {|arg| where("LOWER(#{table_name}.name) = LOWER(?)", arg.to_s.strip)}

  def self.safe_attributes
    [:name, :position, :is_default, :type, :active, :position_name, :is_flagged, :is_closed]
  end

  def self.default
    # Creates a fake default scope so Enumeration.default will check
    # it's type.  STI subclasses will automatically add their own
    # types to the finder.
    if self.descends_from_active_record?
      where(:is_default => true, :type => 'Enumeration').first
    else
      # STI classes are
      where(:is_default => true).first
    end
  end

  # Overloaded on concrete classes
  def option_name
    nil
  end

  def check_default
    if is_default? && is_default_changed?
      Enumeration.where({:type => type}).update_all({:is_default => false})
    end
  end

  # Overloaded on concrete classes
  def objects_count
    0
  end

  def in_use?
    self.objects_count != 0
  end

  # Is this enumeration overriding a system level enumeration?
  def is_override?
    !self.parent.nil?
  end

  alias :destroy_without_reassign :destroy

  # Destroy the enumeration
  # If a enumeration is specified, objects are reassigned
  def destroy(reassign_to = nil)
    if reassign_to && reassign_to.is_a?(Enumeration)
      self.transfer_relations(reassign_to)
    end
    destroy_without_reassign
  end

  def <=>(enumeration)
    position <=> enumeration.position
  end

  def to_s; name end

  # Returns the Subclasses of Enumeration.  Each Subclass needs to be
  # required in development mode.
  #
  # Note: subclasses is protected in ActiveRecord
  def self.get_subclasses
    subclasses
  end

  # Does the +new+ Hash override the previous Enumeration?
  def self.overriding_change?(new, previous)
    if same_active_state?(new['active'], previous.active)
      return false
    else
      return true
    end
  end

  # Are the new and previous fields equal?
  def self.same_active_state?(new, previous)
    new = (new == "1" ? true : false)
    return new == previous
  end



  def check_integrity
    raise "Cannot delete enumeration" if self.in_use?
  end

  def set_default_position
    if position.nil?
      self.position = self.class.pluck(:position).compact.count + 1
    end
  end

  def update_position
    super
    # if position_changed?
    #   self.class.update_all(
    #       "position = coalesce((
    #       select count(*) + 1
    #       from enumerations where id< id  AND type = '#{e}'), 1)"
    #   )
    # end
  end
end
# require_dependency 'enumerations/*.rb'
require_dependency 'religion_type'
require_dependency 'role_type'
require_dependency 'organization_enum'