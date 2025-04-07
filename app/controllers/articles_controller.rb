class ArticlesController < ApplicationController
  before_action :set_id, only: %i[show edit update destroy]

  def index
    @articles = Article.all
  end

  def show
    @comment = @article.comments.new
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article, notice: "Article created successfully."
    else
      flash.alert = "Unable to create article."
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: "Article updated successfully."
    else
      flash.alert = "Unable to update article."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy

    redirect_to root_path, notice: "Article deleted successfully.", status: :see_other
  end

  private
    def article_params
      params.require(:article).permit(:title, :body)
    end

    def set_id
      @article = Article.find(params[:id])
    end
end
