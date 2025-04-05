class CommentsController < ApplicationController
  before_action :set_article_id
  before_action :set_comment, only: [ :edit, :update, :destroy ]

  def index
    @comments = @article.comments
  end

  def create
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article), notice: "Comment was successfully created."
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to article_path(@article), notice: "Comment was successfully updated."
    else
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
