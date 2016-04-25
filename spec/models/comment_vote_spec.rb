require 'rails_helper'

RSpec.describe CommentVote, type: :model do
  it { should have_valid(:user_id).when(2, 3) }
  it { should_not have_valid(:user_id).when(nil) }

  it { should have_valid(:comment_id).when(1, 5) }
  it { should_not have_valid(:comment_id).when(nil) }
end

describe ".calculate_votes" do
  it 'correctly calculates the votes given comment_id' do
    first_vote = FactoryGirl.create(:comment_vote, user_vote: true)
    expect(first_vote.comment.commentVotes.first.user_vote).to be true
  end
end
