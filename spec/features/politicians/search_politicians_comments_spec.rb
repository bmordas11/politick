require 'rails_helper'

feature 'user searches site for politicians' do
  let!(:first_comment)  { FactoryGirl.create(:comment) }
  let!(:second_comment)  { FactoryGirl.create(:comment) }
  let!(:third_comment)  { FactoryGirl.create(:comment) }

  scenario 'can search by name' do
    visit politicians_path

    fill_in 'query', with: first_comment.politician.first_name
    click_on 'Search'

    expect(page).to have_content first_comment.politician.full_name
    expect(page).to_not have_content second_comment.politician.full_name
    expect(page).to_not have_content third_comment.politician.full_name
  end

  scenario 'can search by comment' do
    visit politicians_path

    fill_in 'query', with: second_comment.body
    click_on 'Search'

    expect(page).to have_content second_comment.politician.full_name
    expect(page).to_not have_content first_comment.politician.full_name
    expect(page).to_not have_content third_comment.politician.full_name
  end
end
