class DocumentNote < Note
  belongs_to :document, foreign_key: :owner_id, class_name: 'Document'

  def object
    document
  end

end
