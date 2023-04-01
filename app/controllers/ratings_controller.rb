class RatingsController < ApplicationController
  before_action :require_login

  def create
    @book = Book.find(params[:book_id])
    @rating = current_user.ratings.build(rating_params.merge(book_id: @book.id))
    if @rating.save
      render json: { message: 'Rating added successfully!' }, status: :created
    else
      render json: { error: 'Failed to add rating!' }, status: :unprocessable_entity
    end
  end

  def update
    @rating = current_user.ratings.find(params[:id])
    if @rating.update(rating_params)
      render json: { message: 'Rating updated successfully!' }, status: :ok
    else
      render json: { error: 'Failed to update rating!' }, status: :unprocessable_entity
    end
  end

  def destroy
    @rating = current_user.ratings.find(params[:id])
    @rating.destroy
    render json: { message: 'Rating deleted successfully!' }, status: :ok
  end

  def index
    ratings = Rating.includes(:book, :user)
    render json: ratings.as_json(include: { book: { only: [:title] }, user: { only: [:username] } })
  end

  def show
    rating = Rating.includes(:book, :user).find(params[:id])
    render json: rating.as_json(include: { book: { only: [:title] }, user: { only: [:username] } })
  end


  private

  def rating_params
    params.require(:rating).permit(:value)
  end
end
