class PostsController < ApplicationController
  before_action :require_login

  def index
    @posts = Post.all.order(updated_at: "desc")
  end

  def show
  end

  def create
    post = current_user.posts.new(content: params[:content])
    if post.save
      redirect_to posts_url
    else
      render :index
    end
  end

  def edit
  end

  def change
    post = current_user.posts.find_by(id: params[:id])
    if post
      post.content = params[:content]
      post.save
      redirect_to posts_url
    else
      redirect_to posts_url
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    favos = Favorite.where(post_id: @post.id)
    favos.each do |favo|
      favo.destroy
    end
    @post.destroy
    redirect_to posts_url, notice: "投稿を削除しました"
  end

  private
    def post_params
      params.require(:post).permit(:content)
    end

    def require_login
      if session[:user_id] == nil
        redirect_to login_url, notice: "ログインしてください"
      end
    end
end
