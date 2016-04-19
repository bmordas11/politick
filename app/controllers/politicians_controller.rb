class PoliticiansController < ApplicationController
  before_action :authorize_user, except: [:index, :show]

  def index
    # @politicians = if params[:search] && params[:search] != ""
    #           if !(Politician.search(params[:search]).nil?)
    #             Politician.search(params[:search])
    #           else
    #             []
    #           end
    #         else
    #           Politician.all.order('created_at DESC')
    #         end

    @politicians = Politician.all
  end

  def show
    @politician = Politician.find(params[:id])
  end

  def new
    @politician = Politician.new
  end

  def create
    @politician = politician.new(politician_params)
    if @politician.save
      redirect_to @politician, notice: "Successfully added politician."
    else
      render :new
    end
  end

  protected

  def politician_params
    params.require(:politician).permit(
      :first_name,
      :last_name,
      :political_party,
      :place_of_birth,
      :stance,
      :birthday
    )
  end

  def authorize_user
    if !user_signed_in? || !current_user.admin?
      raise ActionController::RoutingError.new("Not Found")
    end
  end
end
