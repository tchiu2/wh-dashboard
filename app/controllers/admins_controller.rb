class AdminsController < ApplicationController
  before_action :check_permissions

  def index
    @customers = Customer.all
  end

  def login_as_user
    user = User.find(params[:id])

    set_user_session(user)

    redirect_to root_path, notice: "Logged in as #{user.email}"
  end
end
