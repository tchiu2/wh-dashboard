class AdminsController < ApplicationController
  before_action :check_permissions

  def index
    @customers = Customer.all
  end
end
