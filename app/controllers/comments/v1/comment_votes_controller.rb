module Comment::V1
  class CommentVotesController < ApiController
    before_filter :authenticate_user!

    def upvote
      user = current_user.id
      found_vote = CommentVotes.find_by(user: user, comment: params[:comment_id])

      if found_vote == nil
        create_vote(params[:comment_id], user, true)
        render json: CommentVotes.calculate_votes(params[:comment_id])
        return
      else
        flip_vote(found_vote)
        render json: CommentVotes.calculate_votes(params[:comment_id])
      end
    end

    def downvote
      user = current_user.id
      found_vote = CommentVotes.find_by(user: user, api: params[:comment_id])

      if found_vote == nil
        create_vote(params[:comment_id], user, false)
        render json: CommentVotes.calculate_votes(params[:comment_id])
        return
      else
        flip_vote(found_vote)
        render json: CommentVotes.calculate_votes(params[:comment_id])
      end
    end

    def create_vote(comment_id, user_id, vote_bool)
      CommentVotes.create(
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
      warden.user
    end

    def warden
      env['warden']
    end
  end
end
