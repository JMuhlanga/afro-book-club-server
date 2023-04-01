class RatingsController < ApplicationController
    before_action :require_login
  
    def create
      @book = Book.find(params[:book_id])
      @rating = current_user.ratings.build(rating_params.merge(book_id: @book.id))
      if @rating.save
        redirect_to @book, notice: 'Rating added successfully!'
      else
        redirect_to @book, alert: 'Failed to add rating!'
      end
    end
  
    def update
      @rating = current_user.ratings.find(params[:id])
      if @rating.update(rating_params)
        redirect_to @rating.book, notice: 'Rating updated successfully!'
      else
        redirect_to @rating.book, alert: 'Failed to update rating!'
      end
    end
  
    def destroy
      @rating = current_user.ratings.find(params[:id])
      @rating.destroy
      redirect_to @rating.book, notice: 'Rating deleted successfully!'
    end
  
    private
  
    def rating_params
      params.require(:rating).permit(:value)
    end

end
