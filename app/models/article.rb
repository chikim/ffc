class Article < ActiveRecord::Base
  has_attached_file :cover_image, default_url: Settings.articles.default_cover_image_url

  scope :ealier_than, ->article{where("created_at < ?", article.created_at).order("created_at desc").limit(Settings.articles.ealier_articles)}
end
