class AdminsController < ApplicationController
  before_action :authorize_user

  def index
    @admins = User.where(role: 'admin')
    @users = User.all - @admins
    @politicians = Politician.all
  end

  protected

  def authorize_user
    if !user_signed_in? || !current_user.admin?
      redirect_to politicians_path
      flash[:warning] = "Unauthorized to enter this page."
    end
  end
end
