class Playlistrecording < ApplicationRecord
  belongs_to :recording
  belongs_to :playlist
end
