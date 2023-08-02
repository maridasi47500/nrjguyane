class Animateur < ApplicationRecord
    has_and_belongs_to_many :emissions, :join_table => :emissionhasanimateurs

  def image=(uploaded_io)
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    write_attribute(:image, uploaded_io.original_filename)
  end
  def image
    read_attribute(:image)
  end
def self.leplusrecent
order(:created_at => :desc).limit(1)
end
def self.passebientot
order(:created_at => :desc).limit(1)
end
end
