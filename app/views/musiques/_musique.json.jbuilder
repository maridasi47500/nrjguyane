json.extract! musique, :id, :title, :image, :description, :subtitle, :created_at, :updated_at
json.url musique_url(musique, format: :json)
