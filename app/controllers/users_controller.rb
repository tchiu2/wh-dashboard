class UsersController < ApplicationController
  def index
    if current_user
      @user = current_user
      render :show
    else
      redirect_to login_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    @user.email.downcase!

    if @user.save
      flash[:notice] = 'Account created successfully!'
      redirect_to root_path
    else
      flash.now.alert = 'Something went wrong - unable to create an account'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
