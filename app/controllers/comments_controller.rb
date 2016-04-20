class CommentsController < ApplicationController
  before_action :authorize_user

  def new
    @politician = Politician.new
  end

  def create
    @politician = Politician.find(params[:politician_id])
    @comment = @politician.comments.new(comment_params)
    @comment.rating = @comment.rating.to_i
    @comment.user = current_user

    # respond_to do |format|
    if @comment.save
      flash[:success] = "Successfully added comment."
      # format.html { redirect_to [@parent, @child],
      #   notice: 'Child was successfully created.' }
    else
      flash[:warning] = @comment.errors.full_messages.join(', ')
      flash[:warning] += ". Comment not created."
    end
    redirect_to @politician
    # end
  end

  def edit
    @politician = Politician.find(params[:politician_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to politician_path(@comment.politician)
      flash[:success] = "Comment Updated!"
    else
      flash[:warning] = @comment.errors.full_messages.join(', ')
      flash[:warning] += ". Comment Not Updated!"
      render :edit
    end
  end

  def destroy
    @politician = Politician.find(params[:politician_id])
    comment = Comment.find(params[:id])
    if comment.destroy
      flash[:success] = "Comment has been deleted."
    else
      flash[:warning] = "Comment could not be deleted."
    end
    redirect_to politician_path(@politician)
  end

  protected

  def comment_params
    params.require(:comment).permit(
      :body,
      :rating,
      :politician_id,
      :user_id
    )
  end

  def authorize_user
    if !user_signed_in?
      raise ActionController::RoutingError.new("Not Found")
    end
  end
end
