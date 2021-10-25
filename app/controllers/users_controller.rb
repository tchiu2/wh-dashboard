class UsersController < ApplicationController
  before_action :check_permissions, only: [:show]

  def index
    redirect_to login_path and return if !current_user

    if current_user.is_admin?
      redirect_to admins_path
    else
      @user = current_user
      render :show
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = Customer.new(user_params)

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
