class Trainer < ActiveRecord::Base
  validates :name, presence: true
  validates :position, presence: true

  has_attached_file :profile_picture, default_url: Settings.trainers.default_profile_picture_url
end
