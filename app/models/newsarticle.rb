class Newsarticle < ApplicationRecord
  paginates_per 6
  belongs_to :user, optional: true
  has_and_belongs_to_many :photos, :join_table => :posthavephotos
   def image=(uploaded_io)
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    write_attribute(:image, uploaded_io.original_filename)
  end
  def image
    read_attribute(:image)
  end

end
