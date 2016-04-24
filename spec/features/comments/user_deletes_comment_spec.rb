require 'rails_helper'

feature 'user can delete a comment they have made' do
  let!(:comment_one)  { FactoryGirl.create(:comment) }
  let!(:comment_two)  { FactoryGirl.create(:comment) }

  scenario 'successfully deletes their comment' do
    visit root_path

    click_link 'Sign In'
    fill_in 'Email', with: comment_one.user.email
    fill_in 'Password', with: comment_one.user.password
    click_button 'Sign In'
    visit politicians_path
    click_link(comment_one.politician.full_name)

    expect(page).to have_content 'Rating'
    expect(page).to have_content comment_one.body
    expect(page).to have_content comment_one.rating

    click_link "delete-comment-#{comment_one.id}"
    expect(page).to_not have_content comment_one.body
  end
end
