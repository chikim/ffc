class Video < ActiveRecord::Base
  def thumbnail
    Frumber::ThumbnailGetter.get url
  end

  def iframe_src
    Frumber::IframeGetter.get url
  end
end
