require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should have_valid(:body).when('Naughty', 'Nice', nil, '') }

  it { should have_valid(:user_id).when(2, 3) }
  it { should_not have_valid(:user_id).when(nil) }

  it { should have_valid(:politician_id).when(1, 5) }
  it { should_not have_valid(:politician_id).when(nil) }
end
