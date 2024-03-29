class Report < ApplicationRecord

  audited except: [:created_at, :updated_at]

  belongs_to :channel
  belongs_to :created_by, class_name: 'User', optional: true
  belongs_to :updated_by, class_name: 'User', optional: true
  belongs_to :channel_enum

  has_many :save_pivot_tables, dependent: :destroy
  has_many :report_documents
  has_many :shared_reports
  has_many :dashboards
  has_many :users, through: :shared_reports

  validates_presence_of :name

  scope :group_channel_reports, -> { joins(:channel).where(channels: {id: Channel.where(id: Channel.for_user.map(&:id))}) }
  scope :public_channel_reports, -> { joins(:channel).where(channels: {option: 2}) }
  scope :personal_channel_reports, -> { joins(:channel).where(channels: {id: Channel.my_personal_channel}) }
  scope :current_user_shared_reports, -> { joins(:shared_reports).group(:id).having("count(*) > 1") }

  # mount_uploader :document, ReportUploader

  before_create do
    self.created_by_id = User.current.id
  end

  before_save do
    self.name = self.name.strip unless self.name.nil?
    self.updated_by_id = User.current.id
  end

  after_create do
    if channel.is_personal?
      SharedReport.create(user_id: User.current.id, report_id: self.id, channel_id: self.channel.id)
    end
    # make sure that no document is linked
    report_documents.destroy_all
  end

  def active_users
    if channel.is_personal?
      shared_reports.map(&:user) + channel.active_users
    else
      channel.active_users
    end
  end

  def document
    report_documents.first_or_initialize
  end

  def document_url
    @document_url ||= document.file_url
  end

  def self.safe_attributes
    [:name, :category_id, :channel_id, :category_type_id, :user_id, :description, :channel_enum_id ]
  end


end
