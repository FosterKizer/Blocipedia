class WikisController < ApplicationController
  
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @wiki = Wiki.new
  end

  def edit
  
  end

  def create
    @user = User.find(params[:user_id])
    @wiki = Wiki.new(wiki_params)
    if @wiki.save
      flash[:notice] = "Wiki was saved"
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the Wiki. Please try again"
      render :new
    end
  end
  
  private
  
  def wiki_params
    params.require(:wiki).permit(:title, :body, :user_id)
  end
  
end
