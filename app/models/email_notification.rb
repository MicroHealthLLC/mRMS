class EmailNotification < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name, scope: :email_type

  def enabled?
    status?
  end
end
