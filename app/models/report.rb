class Report < ApplicationRecord

  audited except: [:created_at, :updated_at]

  belongs_to :channel
  belongs_to :created_by, class_name: 'User', optional: true
  belongs_to :updated_by, class_name: 'User', optional: true

  has_many :save_pivot_tables
  has_many :report_documents
  has_many :shared_reports
  has_many :dashboards
  has_many :users, through: :shared_reports


  # mount_uploader :document, ReportUploader

  before_create do
    self.created_by_id = User.current.id
  end

  before_save do
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
    [:name, :category_id, :channel_id, :category_type_id, :user_id, :description ]
  end


end
