class CommentsController < ApplicationController
  before_action :authenticate_user!  # Asegura que el usuario esté autenticado
  before_action :set_article
  before_action :set_comment, only: [:destroy, :edit, :update]
  before_action :authorize_user!, only: [:destroy, :edit, :update]

  def create
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user  # Asigna el usuario actual al comentario

    if @comment.save
      redirect_to article_path(@article), notice: 'Comment was successfully added.'
    else
      render 'articles/show'
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to article_path(@article), notice: 'Comment was successfully updated.'
    else
      render 'edit'  # Si la actualización falla, vuelve a la página de edición
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

  # Permitir solo al usuario que creó el comentario realizar ciertas acciones
  def authorize_user!
    unless @comment.user == current_user
      redirect_to article_path(@article), alert: 'No tienes permiso para realizar esta acción.'
    end
  end

  def comment_params
    # Eliminar el atributo 'commenter' ya que no lo necesitas
    params.require(:comment).permit(:body)
  end
end
