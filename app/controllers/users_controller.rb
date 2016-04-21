class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all.order(first_name: :desc)
  end
end
