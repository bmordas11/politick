module Api::V1
  class CommentController < ApplicationController

    def add_comment
      @comment = Comment.new(body: params[:body])
      @politician = Politician.find(params[:politician_id])
      @comment.user = current_user
      @comment.politician = @politician
      @comment.rating = params[:rating].to_i
      if @comment.save
        respond_to do |format|
          format.html { render partial: 'append_comment',
            locals: { politician: @politicians, comment: @comment } }
        end
      end
    end

    private

    def comment_params
      params.require(:comment).permit(
      :body,
      :rating,
      :politician_id
      )
    end
  end
end

# if @comment.save
#   flash[:success] = "Successfully added comment."
# else
#   flash[:warning] = @comment.errors.full_messages.join(', ')
#   flash[:warning] += ". Comment not created."
# end
# redirect_to @politician
