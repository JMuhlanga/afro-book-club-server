class CommentsController < ApplicationController
    before_action :require_login
  
    def create
      @book = Book.find(params[:book_id])
      @comment = current_user.comments.build(comment_params.merge(book_id: @book.id))
      if @comment.save
        redirect_to @book, notice: 'Comment added successfully!'
      else
        @comments = @book.comments.reload
        render 'books/show'
      end
    end
  
    def destroy
      @comment = current_user.comments.find(params[:id])
      @comment.destroy
      redirect_to @comment.book, notice: 'Comment deleted successfully!'
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:content)
    end

end
