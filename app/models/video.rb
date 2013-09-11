class Video < ActiveRecord::Base
  VALID_DOMAINS = %w[youtube youtu vimeo]
  VALID_DOMAIN_REGEX = /^(https?:\/{2})(w{3}\.)?(?<domain>youtube|youtu|vimeo)\.(com|be)+\//

  validates :title, presence: true
  validates :url, presence: true
  validate :valid_domain, if: ->video{video.url}

  def thumbnail
    Frumber::ThumbnailGetter.get url
  end

  def iframe_src
    Frumber::IframeGetter.get url
  end

  private
  def valid_domain
    unless VALID_DOMAINS.include? in_domain_media_url
      errors.add(:url, "invalid url")
    end
  end

  def in_domain_media_url
    self.url.downcase.match(VALID_DOMAIN_REGEX).try(:[], :domain)
  end
end
