module Api::V1
  class CommentController < ApplicationController

    def add_comment
      @comment = Comment.new(body: params[:body])
      @politician = Politician.find(params[:politicianId])
      @comment.user = current_user
      @comment.politician = @politician
      @comment.rating = params[:rating].to_i
      if @comment.save
        respond_to do |format|
          format.html do
            render partial: 'append_comment',
            locals: { politician: @politicians, comment: @comment }
          end
        end
      end

    end

    private

    def comment_params
      params.require(:comment).permit(
        :body,
        :rating,
        :politicianId
      )
    end
  end
end
