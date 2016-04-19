class Comment < ActiveRecord::Base
  belongs_to :politician

  validates :body, presence: true, length: { in: 1..1000 }
end
