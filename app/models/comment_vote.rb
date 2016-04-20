class CommentVotes < ActiveRecord::Base
  belongs_to :comment
  belongs_to :user

  def self.calculate_votes(comment_id)
    @comment = Comment.find(comment_id)
    @upvotes = CommentVotes.where(user_vote: true, comment: @comment).count
    @downvotes = CommentVotes.where(user_vote: false, api: @comment).count
    { upvotes: @upvotes, downvotes: @downvotes }
  end
end
