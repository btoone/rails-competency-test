class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :list]
  before_action :check_ability, only: [:edit, :destroy]

  access all: [:index, :list], editor: :all, user: {except: [:new, :create, :destroy]}

  def index
    @categories = Article.categories
    @articles = Article.all.group_by(&:category)
  end

  def list
    @categories = Article.categories
    @articles = Article.all.group_by(&:category)
  end

  def show
  end

  def new
    @article = current_user.articles.build
  end

  def edit
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

  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was deleted successfully.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content, :category, :user_id)
  end

  def check_ability
    if current_user.has_roles?(:admin, :editor)
      if current_user.has_roles?(:admin)
        # can continue
      elsif current_user != @article.user
        forbidden!
      end
    end
  end
end
