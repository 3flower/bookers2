class FavoritesController < ApplicationController

	before_action :book_params
	def create
		@favorite = current_user.favorites.new(book_id: @book.id)
		@favorite.save
		redirect_back(fallback_location: books_path)
	end

	def destroy
		@book = Book.find(params[:book_id])
		@favorite = current_user.favorites.find_by(book_id: @book.id)
		@favorite.destroy
		redirect_back(fallback_location: books_path)
	end

end
