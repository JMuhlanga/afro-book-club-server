class BooksController < ApplicationController
    before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
  
    def index
      @books = Book.all
    end
  
    def show
      @book = Book.find(params[:id])
      @comments = @book.comments
      @rating = @book.ratings.find_by(user_id: session[:user_id])
    end
  
    def new
      @book = Book.new
    end
  
    def create
      @book = current_user.books.build(book_params)
      if @book.save
        redirect_to @book, notice: 'Book added successfully!'
      else
        render :new
      end
    end
  
    def edit
      @book = current_user.books.find(params[:id])
    end
  
    def update
      @book = current_user.books.find(params[:id])
      if @book.update(book_params)
        redirect_to @book, notice: 'Book updated successfully!'
      else
        render :edit
      end
    end
  
    def destroy
      @book = current_user.books.find(params[:id])
      @book.destroy
      redirect_to books_path, notice: 'Book deleted successfully!'
    end
  
    private
  
    def book_params
      params.require(:book).permit(:title, :img, :bookLink, :description)
    end
    
end
