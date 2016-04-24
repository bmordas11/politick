class CommentsController < ApplicationController
  before_filter :authenticate_user!, except: [:index]

  def new
    @politician = Politician.new
  end

  def create
    @politician = Politician.find(params[:politician_id])
    @comment = @politician.comments.new(comment_params)
    @comment.rating = @comment.rating.to_i
    @comment.user = current_user

    if @comment.save
      flash[:success] = "Successfully added comment."
    else
      flash[:warning] = @comment.errors.full_messages.join(', ')
      flash[:warning] += ". Comment not created."
    end
    redirect_to @politician
  end

  def edit
    @politician = Politician.find(params[:politician_id])
    @comment = Comment.find(params[:id])
    @editing_comment = true
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to politician_path(@comment.politician)
      flash[:success] = "Comment Successfully Updated."
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
end
