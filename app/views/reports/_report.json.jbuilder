json.extract! report, :id, :name, :category_id, :category_type_id, :user_id, :document, :created_at, :updated_at
json.url report_url(report, format: :json)
