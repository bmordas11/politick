class Comment < ActiveRecord::Base
  belongs_to :politician
  belongs_to :user
  has_many :commentVotes

  validates :user_id, presence: true
  validates :politician_id, presence: true
  validates :body, presence: true
  validates :rating, inclusion: { in: [1, 2, 3, 4, 5] }

  def comment_owner?(user)
    user.id == self.user.id
  end
end
