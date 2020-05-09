class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: [:top, :about]

	#デバイス機能実行前にconfigure_permitted_parametersの実行をする。
	protect_from_forgery with: :exception

  protected
  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  #sign_out後のredirect先変更する。rootパスへ。rootパスはhome topを設定済み。
  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
			 keys: [:name, :email, :postal_code, :prefecture_code, :city, :street])
    #sign_upの際にnameのデータ操作を許。追加したカラム。
		devise_parameter_sanitizer.permit(:sign_in, keys: [:name]) # ログイン時はnameを使用
  end

	private

	def set_book
		@book = Book.find(params[:id])
	end

	def book_params
		@book = Book.find(params[:book_id])
	end

	def set_user
		@user = User.find(params[:id])
	end

end
