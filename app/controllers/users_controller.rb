class UsersController < ApplicationController
  
  before_action :authenticate_user!
  
  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = "User information updated"
      redirect_to edit_user_registration_path
    else
      flash[:error] = "Invalid user information"
      redirect_to edit_user_registration_path
    end
  end
  
  def show
    @user = current_user
    @wikis = @user.wikis
    @collaborations = get_collaborated_wikis    
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :role)
  end
  
  def get_collaborated_wikis
    @all_wikis = Wiki.all
    @user = current_user
    @collaborated_wikis = []
    @all_wikis.each do |wiki|
      if wiki.users.include?(@user)
        @collaborated_wikis << wiki
      end
    end
    @collaborated_wikis
  end
  
end
