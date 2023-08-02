class Video < ApplicationRecord
  has_and_belongs_to_many :videoplaylists, :join_table =>:vidhasplaylists
end
