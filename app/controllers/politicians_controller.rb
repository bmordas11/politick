class PoliticiansController < ApplicationController
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

  def new
    @politician = Politician.new
  end
end
