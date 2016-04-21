require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should have_valid(:body).when('Naughty', 'Nice') }
  it { should_not have_valid(:body).when(nil, '') }

  it { should have_valid(:user_id).when(2, 3) }
  it { should_not have_valid(:user_id).when(nil) }

  it { should have_valid(:politician_id).when(1, 5) }
  it { should_not have_valid(:politician_id).when(nil) }
end

describe "#comment_owner?" do
  it 'returns false if user is not comment owner' do
    user = FactoryGirl.create(:user)
    comment = FactoryGirl.create(:comment)
    expect(comment.comment_owner?(user)).to eq false
  end

  it 'return true if user is comment owner' do
    user = FactoryGirl.create(:user)
    comment = FactoryGirl.create(:comment, user: user)
    expect(comment.comment_owner?(user)).to eq true
  end
end
