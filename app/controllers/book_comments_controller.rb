class BookCommentsController < ApplicationController

	before_action :book_params, only: [:create, :destroy]
	def create

		@comment = current_user.book_comments.new(book_comment_params)
		@comment.book_id = @book.id
		@comment.save
	end

	def destroy

		@comment = current_user.book_comments.find_by(book_id: @book.id, id: params[:id])
		@comment.destroy
	end

	private
	def book_comment_params
		params.require(:book_comment).permit(:comment)
	end
end
