  
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @newbook = Book.new
    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday 
    @this_week_book = @books.create_this_week
    @last_week_book = @books.create_last_week
  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
       redirect_to user_path(@user.id),notice:"You have updated user successfully."
    else
       render :edit
    end
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new

  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end


  end

private

  def user_params
    params.require(:user).permit(:name,:introduction,:profile_image)
  end

end