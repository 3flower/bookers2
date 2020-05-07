class FavoritesController < ApplicationController

	before_action :book_params, only: [:create, :destroy]

	def create
		@favorite = current_user.favorites.new(book_id: @book.id)
		@favorite.save
	end

	def destroy
		@book = Book.find(params[:book_id])
		@favorite = current_user.favorites.find_by(book_id: @book.id)
		@favorite.destroy
	end

end
