class BooksController < ApplicationController

  before_action :correct_user, only: [:edit, :update, :destroy, :delete]

  def index
    @book = Book.new
    @books = Book.all
    @createdbook = Book.new
    @user = current_user
  end

  def create
    @createdbook = Book.new(book_params)
    @createdbook.user_id = current_user.id
    if @createdbook.save
      redirect_to book_path(@createdbook.id), notice: 'You have created book successfully.'
    else
      @books = Book.all
      @book = Book.new
      @user = current_user
      render :index
    end
  end

  def show
    @book = Book.new
    @books = Book.find(params[:id])
    @user = @books.user
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to book_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: 'You have updated book successfully.'
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end


end
