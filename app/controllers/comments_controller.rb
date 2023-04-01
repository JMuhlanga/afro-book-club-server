class CommentsController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :set_comment, only: [:show, :destroy]

  def index
    if params[:book_id]
      comments = Book.find(params[:book_id]).comments
    else
      comments = Comment.all
    end

    render json: comments
  end

  def show
    render json: @comment
  end

  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.comments.build(comment_params.merge(book_id: @book.id))
    if @comment.save
      render json: { message: 'Comment added successfully!', comment: @comment }, status: :created
    else
      @comments = @book.comments.reload
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    render json: { message: 'Comment deleted successfully!' }
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :book_id, :user_id)
  end
end
