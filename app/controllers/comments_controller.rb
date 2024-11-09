class CommentsController < ApplicationController
  before_action :set_article
  before_action :set_comment, only: [:destroy, :edit, :update]

  def create
    @comment = @article.comments.build(comment_params)
    if @comment.save
      redirect_to article_path(@article), notice: 'Comment was successfully added.'
    else
      render 'articles/show'
    end
  end

  def edit
    @comment = @article.comments.find(params[:id])
  end
  

  def update
    @comment = @article.comments.find(params[:id])
  
    if @comment.update(comment_params)
      redirect_to article_path(@article), notice: 'Comment was successfully updated.'
    else
      render 'edit' # Si la actualización falla, vuelve a la página de edición
    end
  end
  

  def destroy
    @comment.destroy
    redirect_to article_path(@article), notice: 'Comment was successfully deleted.'
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_comment
    @comment = @article.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
