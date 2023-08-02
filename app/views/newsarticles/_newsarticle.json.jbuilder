json.extract! newsarticle, :id, :type, :title, :content, :image, :comphoto, :subtitle, :user_id, :created_at, :updated_at
json.url newsarticle_url(newsarticle, format: :json)
