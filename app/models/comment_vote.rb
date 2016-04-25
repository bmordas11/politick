class CommentVote < ActiveRecord::Base
  belongs_to :comment
  belongs_to :user

  validates :comment_id, presence: true
  validates :user_id, presence: true

  def self.calculate_votes(comment_id)
    @comment = Comment.find(comment_id)
    @upvotes = CommentVote.where(user_vote: true, comment: @comment).count
    @downvotes = CommentVote.where(user_vote: false, comment: @comment).count
    { upvotes: @upvotes, downvotes: @downvotes }
  end
end
