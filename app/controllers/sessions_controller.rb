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

      session[:user_id] = user.id.to_s
      redirect_to root_path, notice: 'Successfully logged in!'
    else
      flash.now.alert = 'Invalid credentials, please try again.'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)

    redirect_to login_path, notice: 'Logged out!'
  end
end
