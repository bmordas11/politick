class CommentsController < ApplicationController
  before_filter :authenticate_user!, except: [:index]

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
    @comment = Comment.find(params[:id])
    @politician = @comment.politician
    @editing_comment = true
  end

  def update
    @comment = Comment.find(params[:id])
    @politician = @comment.politician
    if @comment.update(comment_params)
      flash[:success] = "Comment Successfully Updated."
      redirect_to politician_path(@comment.politician)
    else
      flash[:warning] = @comment.errors.full_messages.join(', ')
      flash[:warning] += ". Comment Not Updated!"
      render :edit
    end
  end

  def destroy
    @politician = Politician.find(params[:politician_id])
    comment = Comment.find(params[:id])
    flash[:success] = "Comment has been deleted." if comment.destroy
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
