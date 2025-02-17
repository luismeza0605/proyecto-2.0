class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]  # Esto asegurará que el acceso público solo sea para index y show

  def new 
    @article = Article.new
  end

  def index
    @articles = Article.all
  end

  def edit
    @article = Article.find(params[:id])
  end

  def show
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def create
    @article = current_user.articles.build(article_params)  # Cambiado para asociar el artículo con el usuario actual
    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render 'new'
    end
  end
  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path, notice: 'Article and its comments were successfully deleted.'
  end

  private
  def article_params
    params.require(:article).permit(:title, :text)
  end
end
