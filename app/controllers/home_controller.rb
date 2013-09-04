class HomeController < ApplicationController
  def index
  end

  def introduction
    @introduction = Article::Introduction.last
  end

  def rules
    @rules = Article::Rules.last
  end
end
