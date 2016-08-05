class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(session_params[:email],
                                     session_params[:password])

    # fail
    if @user && @user.activated?
      login!(@user)
      redirect_to bands_url
    elsif @user
      flash.now[:errors] = ["User is not activated! Please check your email"]
      render :new
    else
      flash.now[:errors] = ["User does not exist"]
      render :new
    end
  end

  def destroy
    logout! if current_user
    redirect_to new_session_url
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
