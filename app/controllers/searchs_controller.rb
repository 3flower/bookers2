class SearchsController < ApplicationController

  def search
    @book = Book.new
    @user_or_book = params[:job]
    @how_search = params[:option]
    if @user_or_book == "users"
      @users = User.search(params[:search], @user_or_book, @how_search)
    elsif @user_or_book == "books"
      @books = Book.search(params[:search], @user_or_book, @how_search)
    else
    end
  end
end
