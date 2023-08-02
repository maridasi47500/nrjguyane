class Photo < ApplicationRecord
  has_and_belongs_to_many :newsarticles, :join_table => :posthavephotos
end
