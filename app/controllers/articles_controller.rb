class ArticlesController < ApplicationController
  def index
    @categories = Article.categories

    @superhero_articles = Article.superhero.limit(3)
    @local_articles     = Article.local.limit(3)
    @health_articles    = Article.health.limit(3)
    @money_articles     = Article.money.limit(3)
  end
end
