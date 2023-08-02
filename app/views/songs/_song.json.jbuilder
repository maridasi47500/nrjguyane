json.extract! song, :id, :title, :artist, :created_at, :updated_at,:duree,:filename
json.url song_url(song, format: :json)
