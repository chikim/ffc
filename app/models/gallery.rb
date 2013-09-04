class Gallery < ActiveRecord::Base
  has_many :photos

  def cover_image
    (photos.find_by(id: cover_photo_id) || photos.first).try :image
  end
end
