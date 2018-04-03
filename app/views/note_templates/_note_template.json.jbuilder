json.extract! note_template, :id, :title, :note, :created_at, :updated_at
json.url note_template_url(note_template, format: :json)