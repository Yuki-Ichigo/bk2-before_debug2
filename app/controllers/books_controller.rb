class BooksController < ApplicationController
    before_action :authenticate_user!

  def index
    @book_new = Book.new
    @books = Book.all
  end

  def create
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    if @book_new.save
      redirect_to book_path(@book_new), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

    def show
    @user = current_user
    @book_new = Book.new
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
    if current_user != @book.user
      redirect_to books_path
    end
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def delete
    @book = Book.find(params[:id])
    @book.destoy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
