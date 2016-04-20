class AdminsController < ApplicationController
  before_action :authorize_user

  def index
    @admins = User.where(role: 'admin')
    @users = User.all - @admins
    @politicians = Politician.all
  end

  def show
    @admin = Admin.find(params[:id])
  end

  def new
  end

  def create
  end

  protected

  def authorize_user
    if !user_signed_in? || !current_user.admin?
      raise ActionController::RoutingError.new("Not Found")
    end
  end
end
