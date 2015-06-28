class CollaboratorsController < ApplicationController
  
  def new
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new
    @users = (User.all - [current_user])
  end
  
  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = @wiki.collaborators.create(collab_params)
    if @collaborator.save
      flash[:notice] = "Collaborators have been saved"
      redirect_to root_path
    else
      flash[:error] = "There was an error saving your collaborators. Please try again"
      render :new
    end
  end
  
  def destroy
    
  end
  
  private
  
  def collab_params
    params.require(:collaborator).permit(:user_id, :wiki_id)
  end
  
end
