class Politician < ActiveRecord::Base
  has_many :comments

  def full_name
    "#{first_name} #{last_name}"
  end
end
