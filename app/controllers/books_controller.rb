class BooksController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]

  def index
    books = Book.includes(:comments, :user)
    render json: books.as_json(include: { 
      comments: { 
        include: { user: { only: [:username] } } 
      }, 
      user: { only: [:username] }
    })
  end
  
  def show
    book = Book.includes(:comments, :user).find(params[:id])
    render json: book.as_json(include: { comments: { include: { user: { only: [:username] } } }, user: { only: [:username] } })
  end

  def new
    @book = Book.new
    render json: @book
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      render json: { book: @book, message: 'Book added successfully!' }, status: :created
    else
      render json: { errors: @book.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def edit
    @book = current_user.books.find(params[:id])
    render json: @book
  end

  def update
    @book = current_user.books.find(params[:id])
    if @book.update(book_params)
      render json: { book: @book, message: 'Book Updated successfully!' }, status: :created
    else
      render json: { errors: @book.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @book = current_user.books.find(params[:id])
    @book.destroy
    render json: { message: 'Book deleted successfully!' }

  end

  private

  def book_params
    params.require(:book).permit(:title, :img, :bookLink, :description)
  end
end
