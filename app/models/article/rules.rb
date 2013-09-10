class Article::Rules < Article
  validates :title, presence: true
end
