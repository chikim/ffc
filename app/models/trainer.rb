class Trainer < ActiveRecord::Base
  has_attached_file :profile_picture, default_url: Settings.trainers.default_profile_picture_url
end
