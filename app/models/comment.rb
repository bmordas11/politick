class Comment < ActiveRecord::Base
  belongs_to :politician, dependent: :destroy
  belongs_to :user

  validates :body, presence: true, length: { in: 1..1000 }

  def comment_owner?(user)
    user.id == self.user.id
  end
end
