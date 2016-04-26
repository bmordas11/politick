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
    second_vote = FactoryGirl.create(
      :comment_vote,
      comment: first_vote.comment,
      user_vote: false
    )
    FactoryGirl.create(
      :comment_vote,
      comment: first_vote.comment,
      user_vote: true
    )
    expect(first_vote.comment.id).to eq second_vote.comment.id
    vote_totals = CommentVote.calculate_votes(first_vote.comment.id)
    expect(vote_totals[:upvotes]).to eq 2
    expect(vote_totals[:downvotes]).to eq 1
    expect(first_vote.comment.commentVotes.first.user_vote).to be true
  end
end
