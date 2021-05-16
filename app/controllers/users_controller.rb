class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = Book.all
    @newbook = Book.new  
  end
  
 
  
  def update
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
    
  end
 
  def edit
    @user = User.find(params[:id])
    
  end

private
  
  def user_params
    params.require(:user).permit(:name,:introduction, :profile_image)
  end
  
end