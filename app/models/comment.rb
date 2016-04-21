class Comment < ActiveRecord::Base
  belongs_to :politician
  belongs_to :user

  validates :body, presence: true, length: { in: 1..1000 }
  validates :user_id, presence: true
  validates :politician_id, presence: true

  def comment_owner?(user)
    user.id == self.user.id
  end
end
