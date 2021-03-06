class User < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :commentVotes, dependent: :destroy
  has_many :politicians

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    role == 'admin'
  end

  def politician?
    role == 'politician'
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
