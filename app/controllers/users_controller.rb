class UsersController < ApplicationController
	before_action :baria_user, only: [:update, :edit, :destroy]
	before_action :set_user, only: [:show, :edit, :update, :follows, :followers]

  def show
  	@books = @user.books
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def index
  	@users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def edit
  end

  def update
  	if @user.update(user_params)
  		redirect_to @user, notice: "successfully updated user!"
  	else
  		render "edit"
  	end
  end

	def follows
		@users = @user.followings
	end

	def followers
		@users = @user.followers
	end

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image, :postal_code, :prefecture_code, :city, :street)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
   def baria_user
  	unless params[:id].to_i == current_user.id
  		redirect_to user_path(current_user)
  	end
   end

	 # def zipedit
		#  params.require(:user).permit(:postal_code, :prefecture_name, :city, :street, :building)
	 # end
end
