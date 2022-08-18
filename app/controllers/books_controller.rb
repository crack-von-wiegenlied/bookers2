class BooksController < ApplicationController

  before_action :correct_user, only: [:edit, :update, :destroy, :delete]

  def index
    @book = Book.new
    @books = Book.all
    @createdbook = Book.new
  end

  def create
    @createdbook = Book.new(book_params)
    @createdbook.user_id = current_user.id
    if @createdbook.save
      redirect_to books_path, notice: 'You have created book successfully.'
    else
      @books = Book.all
      @book = Book.new
      render :index
    end
  end

  def show
    @book = Book.new
    @createdbooks = Book.find(params[:id])
    @user = @createdbooks.user
    @books = @user.books
  end

  def edit
    @book = Book.find(params[:id])
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
