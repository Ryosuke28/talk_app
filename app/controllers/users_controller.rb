class UsersController < ApplicationController
  before_action :require_login

  def index
    @users = User.all.order(id: "asc")
  end

  def show
    @user = User.find(params[:id])

    @my_posts = Post.where(user_id: @user.id).order(updated_at: "desc")
    @my_likes = Favorite.where(user_id: @user.id, likes: 1)
    @my_favorites = Favorite.where(user_id: @user.id, favorites: 1)
  end

  def edit
  end

  def new
    @user = User.new(image: "human.jpg")
  end

  def create
    @user = User.new(user_params)
    @user.image = "human.jpg"

    if @user.save
      redirect_to users_url
     else
      flash[:notice] = "データを入力してください"
      render new_user_path
     end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.attributes = user_params

    if params[:image] != nil
      @user.image = @user.id.to_s + "_img.jpg"
      output = Rails.root.join('public/images', @user.image)
      File.open(output, 'w+b') do |f|
        f.write params[:image].read
      end
    end

    if @user.save
      redirect_to users_url
     else
      flash[:notice] = "データを入力してください"
      render new_user_path
     end
  end


  def admin
    user = User.find(params[:user_id])
    if user.admin
      user.admin = false 
    else
      user.admin = true
    end
    user.save
    redirect_to users_url
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :tel, :image, :password, :password_confirmation)
    end

    def require_login
      if session[:user_id] == nil
        redirect_to login_url, notice: "ログインしてください"
      end
    end
end
