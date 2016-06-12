class Politician < ActiveRecord::Base
  has_many :comments, dependent: :destroy

  validates :first_name, presence: true, length: { in: 1..70 }
  validates :first_name, uniqueness: {scope: [:last_name, :political_party]}
  validates :last_name, presence: true, length: { in: 1..70 }
  validates :political_party, presence: true, length: { in: 1..70 }
  validates :stance, presence: true, length: { in: 0..3000 }

  include PgSearch
  pg_search_scope :search_by_attributes, against: [
    :first_name,
    :last_name,
    :political_party,
    :place_of_birth,
    :stance
  ], using: { tsearch: { prefix: true, dictionary: "english" } }

  pg_search_scope :search_comments,
    associated_against: { comments: [:body, :rating] },
    using: { tsearch: { prefix: true, dictionary: "english" } }

  scope :search, -> (query) do
    if query.present?
      search_by_attributes(query) + search_comments(query)
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def find_average_rating
    users_with_comments = comments.map { |comment| comment.user }
    users_with_comments.uniq! { |user| user.id }
    return "N/A" if users_with_comments.empty?

    total_rating = 0.0
    users_with_comments.each do |user|
      user_rating = 0.0
      politicians_comments = Comment.where(politician_id: id, user_id: user.id)
      politicians_comments.each { |comment| user_rating += comment.rating }
      total_rating += user_rating / politicians_comments.count
    end
    average_rating = total_rating / users_with_comments.length
    average_rating = '%.1f' % [(average_rating * 10).round / 10.0]
    average_rating
  end
end
