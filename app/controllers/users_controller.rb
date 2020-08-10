class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @book_new = Book.new
    @books = @user.books
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit

    @user = User.find(params[:id])
    @book_new = Book.new
    @books = @user.books
    if current_user != @user
      redirect_to user_path(current_user)
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      @book_new = Book.new
      @books = @user.books    
      render "show"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
