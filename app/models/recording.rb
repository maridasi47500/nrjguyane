class Recording < ApplicationRecord
  def duration
    t = Thread.new do
    @aa = `ffprobe -print_format json -show_streams -show_format -v error #{Rails.root.to_s+"/public/uploads/"+filename}`
        end
      t.join

    @aa
    JSON.parse(@aa)["format"]["duration"]
  rescue
    "my error"
  end

def recording=(uploaded_io)
myfilename=(0...8).map { (65 + rand(26)).chr }.join
File.open(Rails.root.join('public', 'uploads', myfilename+".wav"), 'wb') do |file|
  file.write(uploaded_io.read)
end
write_attribute(:filename,myfilename+".wav")

end
def filename
read_attribute(:filename)
end

end
