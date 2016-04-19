class Politician < ActiveRecord::Base
  has_many :comments

  validates :first_name, presence: true, length: { in: 1..70 }
  validates :first_name, uniqueness: {scope: [:last_name, :political_party]}
  validates :last_name, presence: true, length: { in: 1..70 }
  validates :political_party, presence: true, length: { in: 1..70 }

  def full_name
    "#{first_name} #{last_name}"
  end
end
