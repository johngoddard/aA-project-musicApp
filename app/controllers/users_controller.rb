class UsersController < ApplicationController
  before_action :find_user, only: [:show, :activate]

  def new
    @user = User.new
  end

  def activate
    if @user.activation_token = params[:activation_token]
      @user.activated = true
      @user.save
      login!(@user)
      redirect_to bands_url
    else
      render text: "That link does not work for you"
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      msg = UserMailer.activation_email(@user)
      msg.deliver
      render text: "You must verify your email before you can use the site"
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show

  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
