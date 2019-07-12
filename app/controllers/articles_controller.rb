class ArticlesController < ApplicationController
  def index
    @categories = Article.categories
    @articles = Article.all.group_by(&:category)
  end
end
