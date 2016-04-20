module Comment::V1
  class CommentController < ApplicationController

    def change
      @comments = Comment.where(politician_id: params[:politician_id])

      respond_to do |format|
        format.html { render partial: 'change',
          locals: { politician: @politicians }}
      end
    end
  end
end
