module Api::V1
  class CommentVotesController < ApplicationController
    before_filter :authenticate_user!

    def upvote
      user = current_user.id
      found_vote = CommentVote.find_by(user: user, comment: params[:commentId])

      if found_vote.nil?
        create_vote(params[:commentId], user, true)
        render json: CommentVote.calculate_votes(params[:commentId])
        return
      else
        flip_vote(found_vote)
        render json: CommentVote.calculate_votes(params[:commentId])
      end
    end

    def downvote
      user = current_user.id
      found_vote = CommentVote.find_by(user: user, comment: params[:commentId])

      if found_vote.nil?
        create_vote(params[:commentId], user, false)
        render json: CommentVote.calculate_votes(params[:commentId])
        return
      else
        flip_vote(found_vote)
        render json: CommentVote.calculate_votes(params[:commentId])
      end
    end

    def create_vote(comment_id, user_id, vote_bool)
      CommentVote.create(
        user: User.find(user_id),
        comment: Comment.find(comment_id),
        user_vote: vote_bool)
    end

    def flip_vote(vote)
      if vote.user_vote
        vote.user_vote = false
      else
        vote.user_vote = true
      end
      vote.save
    end

    private

    def current_user
      env['warden'].user
    end
  end
end
