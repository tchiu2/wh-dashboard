class SessionsController < ApplicationController
  def new
    redirect_to root_path if current_user
  end

  def create
    user = User.find_by(email: params[:login][:email].downcase)

    if user && user.authenticate(params[:login][:password])
      # Make sure we record the current timestamp to updated_at since we're
      # using it to indicate the most recent login
      user.touch

      set_user_session(user)
      set_admin_session(user) if user.is_admin?

      redirect_to root_path, notice: 'Successfully logged in!'
    else
      flash.now.alert = 'Invalid credentials, please try again.'
      render :new
    end
  end

  def destroy
    if logged_in_as_other_user?
      other_user = current_user

      set_user_session(current_admin_user)

      redirect_to admins_path, notice: "No longer logged in as #{other_user.email}"
    else
      session.delete(:user_id)
      session.delete(:admin_user_id) if session[:admin_user_id]

      redirect_to login_path, notice: 'Logged out!'
    end
  end

  private

  def logged_in_as_other_user?
    current_admin_user.present? && session[:user_id] != session[:admin_user_id]
  end
end
