class Song < ApplicationRecord
  def duration
    t = Thread.new do
    `ffprobe -print_format json -show_streams -show_format -v error #{Rails.root.to_s+"/public/uploads/"+filename}`
        end

    t.join
  end
  
end
