require 'rails_helper'

RSpec.describe Politician, type: :model do
  it { should have_valid(:first_name).when('John', 'Sally') }
  it { should_not have_valid(:first_name).when(nil, '') }

  it { should have_valid(:last_name).when('Smith', 'Swanson') }
  it { should_not have_valid(:last_name).when(nil, '') }

  it { should have_valid(:political_party).when('Republic', 'Democrate') }
  it { should_not have_valid(:political_party).when(nil, '') }

  it 'has unique first_name, last_name, political_party constraint' do
    FactoryGirl.create(
      :politician,
      first_name: 'Bob',
      last_name: 'Hope',
      political_party: 'Green Party'
    )
    politician2 = Politician.new(
      first_name: 'Bob',
      last_name: 'Hope',
      political_party: 'Green Party'
    )

    expect(politician2).to_not be_valid
    expect(politician2.errors).to_not be_blank
  end
end

describe "#full_name" do
  it 'is not an admin if the role is not admin' do
    billy = FactoryGirl.create(
      :politician,
      first_name: 'Billy',
      last_name: 'Johanson'
    )
    expect(billy.full_name).to eq('Billy Johanson')
  end
end
