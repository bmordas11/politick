class UsersController < ApplicationController
  before_action :authenticate_user!

  def destroy
    user = User.find(params[:id])
    flash[:success] = "User has been deleted." if user.destroy
    redirect_to admins_path
  end
end
