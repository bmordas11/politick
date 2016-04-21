class PoliticiansController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index]

  def index
    @no_results = false
    @politicians = Politician.search(params[:query])
    if @politicians.empty? && params[:query]
      @no_results = true
    end
  end

  def show
    @politician = Politician.find(params[:id])
    @comments = @politician.comments
    @comment = Comment.new
  end

  def new
    @politician = Politician.new
  end

  def create
    @politician = Politician.new(politician_params)
    if @politician.save
      flash[:sucess] = "Successfully added politician."
    else
      flash[:warning] = @politician.errors.full_messages.join(', ')
      flash[:warning] += ". Politician not added."
    end
    redirect_to @politician
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

end
