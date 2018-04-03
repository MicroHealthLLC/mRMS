class PostAttachment < Attachment
  belongs_to :owner, class_name: 'News'
end