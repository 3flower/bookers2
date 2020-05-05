class RelationshipsController < ApplicationController

	before_action :set_user, only: [:create, :destroy]

	def create
		following = current_user.follow(@user)
		redirect_back(fallback_location: books_path)
	end

	def destroy
		following = current_user.unfollow(@user)
		redirect_back(fallback_location: books_path)
	end

	private

	def set_user
		@user = User.find(params[:follow_id])
	end
end
