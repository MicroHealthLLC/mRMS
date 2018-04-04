class PostNote < Note
  belongs_to :news, foreign_key: :owner_id, class_name: 'News'

  def object
    news
  end

end
