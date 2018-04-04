json.extract! news, :id, :title, :summary, :description, :user_id, :notes_count, :created_at, :updated_at
json.url news_index_url(news, format: :json)