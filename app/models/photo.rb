class Photo < ActiveRecord::Base
  belongs_to :gallery

  has_attached_file :image, default_url: Settings.photos.default_image_url
end
