class BooksController < ApplicationController
  # before_action :authorize, only: [:create, :destroy, :update]
  before_action :set_book, only: [:show, :update, :destroy]

  def index
    books = Book.includes(:comments)
    render json: books.as_json(include: { comments: { include: { user: { only: [:username] } } } })
  end

  def user_books
    books = Book.includes(:comments, :user).where(user_id: params[:user_id])
    render json: books.as_json(include: { comments: { include: { user: { only: [:username] } } }, user: { only: [:username] } })
  end
  

  def show
    book = Book.includes(:comments, :user).find(params[:id])
    render json: book.as_json(include: { comments: { include: { user: { only: [:username] } } }, user: { only: [:username] } })
  end
  

  def create
    book = Book.create(book_params)
   
    if book.persisted?
      render json: book, status: :created, location: book
    else
      render json: book.errors, status: :unprocessable_entity
    end
  end
  
  
  
  

  def update
    book = Book.update(book_params)
    if book.persisted?
      render json: book
    else
      render json: book.errors, status: :unprocessable_entity
    end
  end
  
  def destroy
    book.destroy
  end
  

  private

  def set_book
    book = Book.find(params[:id])
  end      

  def book_params
    params.require(:book).permit(:title, :img, :bookLink, :description, :user_Id).tap do |whitelisted|
      whitelisted[:user_id] = params[:user_Id]
    end
  end
  
end

