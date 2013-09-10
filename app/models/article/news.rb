class Article::News < Article
  validates :title, presence: true
end
