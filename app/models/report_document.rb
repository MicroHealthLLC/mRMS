class ReportDocument < ApplicationRecord
  include ReportsHelper
  belongs_to :user, optional: true
  belongs_to :report, optional: true

  before_create do
    self.user_id = User.current.id
  end

  # after_save do
  #   report.save_pivot_tables.delete_all
  # end

  mount_uploader :file, ReportUploader

  validates_presence_of :file
  # validates :file,
  #           :file_size => {
  #               :less_than_or_equal_to => Setting[:spreadsheet_limit].to_i.megabytes.to_i
  #           }
 # validate :check_file_size
 #  validate :read_content

  def self.safe_attributes
    [:id, :file, :original_content, :changed_content, :report_id, :_destroy]
  end

  def content
    changed_content ? JSON.parse(changed_content.to_s) : JSON.parse(original_content) rescue  [[], []]
  end

 # def check_file_size
 #   if file
 #     if file.size > Setting[:spreadsheet_limit].to_i.megabytes.to_i
 #       self.errors.add(:file, "file size exceeded #{Setting[:spreadsheet_limit]}MB")
 #     end
 #   end
 # end

  before_destroy do
    if file.present?
      self.remove_file!
    end
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
