class BookCommentsController < ApplicationController

	before_action :book_params, only: [:create, :destroy]
	def create

		@comment = current_user.book_comments.new(book_comment_params)
		@comment.book_id = @book.id
		@comment.save
		redirect_back(fallback_location: books_path)
	end

	def destroy

		@comment = current_user.book_comments.find_by(book_id: @book.id)
		@comment.destroy
		redirect_back(fallback_location: books_path)
	end

	private
	def book_comment_params
		params.require(:book_comment).permit(:comment)
	end
end
