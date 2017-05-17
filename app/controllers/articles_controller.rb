class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "dhh", password: "secret",
except: [:index, :show]

  def index
    @article = Article.all
  end

#  before_filter :filter

#index GET /articles
  def index
    @articles =Article.all
  end

#show GET /articles/:id
  def show
    @article = Article.find(params[:id])
  end

#new is a VIEW tempelate for create
  def new
    @article = Article.new
  end

#edit is a VIEW tempelate for update
#edit GET /articles/:id/edit
  def edit
    @article = Article.find_by_id(params[:id])
    unless @article
      render text: 'missing articles'
    end
  end

#create POST /articles
def create
  @article = Article.new(article_params)

  if @article.save
    redirect_to @article
  else
    render 'new'
  end
end

#update PUT /articles/id
def update
  @article = Article.find(params[:id])

  if @article .update(article_params)
    redirect_to @article
  else
    render 'edit'
  end
end

#destroy DELTE /articles/:id(.:format)
def destroy
  @article = Article.find(params[:id])
  @article.destroy

  redirect_to articles_path
end

  private
    def article_params
      params.require(:article).permit(:title, :text)
    end

  #  def filter
  #    if params[:id] != '1'
  #      render text: 'you do have permission to view this article'
  #  end

end
