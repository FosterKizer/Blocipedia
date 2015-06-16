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
    @user = current_user
    @wiki = Wiki.find(params[:id])
  end

  def create
    @user = current_user
    @wiki = @user.wikis.create(wiki_params)
    if @wiki.save
      flash[:notice] = "Wiki was saved"
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the Wiki. Please try again"
      render :new
    end
  end
  
  def update
    @user = current_user
    @wiki = Wiki.find(params[:id])
    if @wiki.update_attributes(wiki_params)
      redirect_to @wiki
    else
      flash[:error] = "Error saving wiki. Please try again"
      render :edit
    end
  end
  
  def destroy
    @user = current_user
    @wiki = Wiki.find(params[:id])
    title = @wiki.title
    if @wiki.destroy
      flash[:notice] = "\"#{title}\" was deleted successfully"
      redirect_to root_path
    else
      flash[:error] = "There was an error deleting the wiki"
      render :show
    end
  end
  
  private
  
  def wiki_params
    params.require(:wiki).permit(:title, :body, :user_id)
  end
  
end
