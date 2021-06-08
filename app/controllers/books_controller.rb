class BooksController < ApplicationController
  def index
    to  = Time.current.at_end_of_day
    from  = (to - 6.day).at_beginning_of_day
    @books = Book.includes(:favorited_users).
    sort{|a,b|
    b.favorited_users.includes(:favorites).where(created_at: from...to).size <=> 
    a.favorited_users.includes(:favorites).where(created_at: from...to).size
      
    }
    @user = current_user
    @book = Book.new

  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
       redirect_to book_path(@book.id),notice:"You have created book successfully."
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def show
    @book=Book.find(params[:id])
    @user = @book.user  #@bookの投稿者(@bookの親)
    @newbook = Book.new
    @book_comment = BookComment.new
   
  end

  def edit
    @book=Book.find(params[:id])
    @user = @book.user
    if @user != current_user
      redirect_to books_path
    end
    
  end
  
  def update
    @book=Book.find(params[:id])
   if  @book.update(book_params)
    redirect_to book_path(@book.id),notice:"You have updated book successfully."
   else
     render :edit
   end
  end
  
  def destroy
    @book=Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
