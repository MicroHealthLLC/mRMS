class Attachment < ApplicationRecord
  belongs_to :user, optional: true

  before_create do
    self.user_id = User.current.id
  end

  mount_uploader :file, AttachmentUploader

  validates_presence_of :file, :type

  def self.safe_attributes
    [:id, :file, :type, :description, :owner_id, :_destroy]
  end
end
