class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: :index
  def index
    @categories = Article.categories
    @articles = Article.all.group_by(&:category)
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
				format.html { redirect_to article_url(@article), notice: 'Article was created successfully' }
				format.json { render :show, status: :created, location: @article }
      else
				format.html { render :new }
				format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :category)
  end
end
