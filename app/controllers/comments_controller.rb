class CommentsController < ApplicationController
  before_action :set_article

  def index
    @comments = @article.comments
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = @article.comments.build(comment_params)

    if @comment.save
      flash[:success] = 'Article successfully created.'
      redirect_to article_comments_path(@article)
    else
      render :new
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = @article.comments.find(params[:id])

    if @comment.update_attributes(comment_params)
      flash[:success] = 'Comment successfully updated.'
      redirect_to article_comments_path(@article)
    else
      render :edit
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end
end
