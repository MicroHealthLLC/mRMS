class ReportDocument < ApplicationRecord
  include ReportsHelper
  belongs_to :user, optional: true
  belongs_to :report

  before_create do
    self.user_id = User.current.id
  end

  mount_uploader :file, ReportUploader

  validates_presence_of :file, :report_id
  validates :file,
            :file_size => {
                :less_than_or_equal_to => 5.megabytes.to_i
            }
  validate :read_content

  def self.safe_attributes
    [:id, :file, :original_content, :changed_content, :report_id, :_destroy]
  end

  def content
    changed_content ? JSON.parse(changed_content.to_s) : JSON.parse(original_content) rescue  [[], []]
  end

  def read_content
    begin
      content = render_pivot_information(file)
      self.original_content = content.to_json
    rescue StandardError => e
      self.errors.add(:file, "Could not read the doc, error #{e.message}")
    end
  end
end
