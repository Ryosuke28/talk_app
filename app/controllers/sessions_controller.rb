class SessionsController < ApplicationController
  def new
    @headerflag = 1
  end

  def create
    user = User.find_by(email: session_params[:email])

    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to posts_url, notice: 'ログインしました'
    else
      @headerflag = 1
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to login_url, notice: 'ログアウトしました'
  end





  private
    def session_params
      params.require(:session).permit(:email, :password)
    end
end
