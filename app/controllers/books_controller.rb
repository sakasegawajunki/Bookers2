class BooksController < ApplicationController
  
  # impressionist :actions=> [:show, :index]

  
  
  def index
    to  = Time.current.at_end_of_day
    from  = (to - 6.day).at_beginning_of_day
    @books = Book.includes(:favorited_users).
    sort{|a,b|
        b.favorited_users.includes(:favorites).where(created_at: from...to).size <=> 
        a.favorited_users.includes(:favorites).where(created_at: from...to).size
      }
    @books = Book.page(params[:page]).per(5)
    # @books = Book.left_joins(:favorites).group(:id).where(favorites: { created_at: from...to}).order('count(books.id) desc').limit(10)
    @book = Book.new
    @user = current_user
    @rank_books = Book.order(impressions_count: "DESC")
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
    impressionist(@book, nil, unique: [:ip_address])
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
    params.require(:book).permit(:title, :body ,:rate)
  end

end
