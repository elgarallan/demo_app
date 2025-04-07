class CommentsController < ApplicationController
  before_action :set_article_id
  before_action :set_comment, only: [ :show, :edit, :update, :destroy ]

  def index
    @comments = @article.comments
  end

  def create
    @comment = @article.comments.new(comment_params)

    if @comment.save
      redirect_to article_path(@article), notice: "Comment was successfully created."
    else
      flash.alert = "Unable to create comment."
      render "articles/show", status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to article_path(@article), notice: "Comment was successfully updated."
    else
      flash.alert = "Unable to update comment."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to article_path(@article), notice: "Comment was successfully deleted."
  end

  private

    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end

    def set_article_id
      @article = Article.find(params[:article_id])
    end

    def set_comment
      @comment = @article.comments.find(params[:id])
    end
end
