class FavoritesController < ApplicationController
  before_action :require_login

  def good
    @good = Favorite.find_by(
      post_id: params[:id],
      user_id: session[:user_id]
    )

    if @good == nil
      @good = Favorite.new(
        post_id: params[:id],
        user_id: session[:user_id],
        likes: 1,
        favorites: 0
        )
    elsif @good.likes == 1
      @good.likes = 0
    elsif @good.likes == 0
      @good.likes = 1
    end
    
    @good.save
    if params[:user]
      redirect_to "/users/#{params[:user]}"
    else
      redirect_to posts_url
    end
  end

  def favorite
    @favorite = Favorite.find_by(
      post_id: params[:id],
      user_id: session[:user_id]
    )

    if @favorite == nil
      @favorite = Favorite.new(
        post_id: params[:id],
        user_id: session[:user_id],
        likes: 0,
        favorites: 1
        )
    elsif @favorite.favorites == 1
      @favorite.favorites = 0
    elsif @favorite.favorites == 0
      @favorite.favorites = 1
    end
    
    @favorite.save
    if params[:user]
      redirect_to "/users/#{params[:user]}"
    else
      redirect_to posts_url
    end
  end

  private
    def require_login
      if session[:user_id] == nil
        redirect_to login_url, notice: "ログインしてください"
      end
    end
end
