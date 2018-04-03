class UserAttachment < Attachment
  belongs_to :owner, class_name: 'User'
end