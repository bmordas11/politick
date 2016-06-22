class PoliticiansController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index]

  def index
    @no_results = false

    if params[:query] == '' || params[:query].nil?
      @politicians = Politician.order(first_name: :asc)
    elsif params[:query].present?
      @politicians = Politician.search(params[:query])
      @politicians.uniq! { |politician| politician.id }
    end
    @politicians = Kaminari.paginate_array(@politicians).page(params[:page])

    @no_results = true if @politicians.empty?
  end

  def show
    @politician = Politician.find(params[:id])
    @comments = @politician.comments
    @comment = Comment.new
    @editing_comment = false
    @upvotes = []
    @downvotes = []
    @comments.each do |comment|
      @upvotes << CommentVote.where(user_vote: true, comment: comment).count
      @downvotes << CommentVote.where(user_vote: false, comment: comment).count
    end
  end

  def new
    @add_or_update = 'Add'
    @politician = Politician.new
  end

  def create
    @politician = Politician.new(politician_params)
    if @politician.save
      flash[:sucess] = "Successfully added politician."
      redirect_to @politician
    else
      flash[:warning] = @politician.errors.full_messages.join(', ')
      flash[:warning] += ". Politician not added."
      render :new, object: @politician
    end
  end

  def edit
    @politician = Politician.find(params[:id])
  end

  def update
    @politician = Politician.find(params[:id])
    if @politician.update_attributes(politician_params)
      flash[:sucess] = "Successfully updated politician."
      redirect_to @politician
    else
      flash[:warning] = @politician.errors.full_messages.join(', ')
      flash[:warning] += ". Politician not updated."
      render :edit, object: @politician
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

end
