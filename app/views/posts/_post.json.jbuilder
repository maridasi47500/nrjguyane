json.extract! post, :id, :name, :image, :description, :created_at, :updated_at
json.url post_url(post, format: :json)
