require 'rails_helper'

feature 'user can edit a comment they have made' do
  let!(:comment_one)  { FactoryGirl.create(:comment) }
  let!(:comment_two)  { FactoryGirl.create(:comment) }

  scenario 'successfully updates their comment' do
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

    click_link "edit-comment-#{comment_one.id}"
    expect(page).to have_content comment_one.body

    fill_in 'comment_body', with: 'This is testing the comment update!'
    choose('3')
    click_button 'Update Comment'
    expect(page).to have_content('Comment Successfully Updated.')
    expect(page).to have_content 'This is testing the comment update!'
    expect(page).to have_content '3'
  end

  scenario "they fail to update their comment" do
    visit root_path

    click_link 'Sign In'
    fill_in 'Email', with: comment_two.user.email
    fill_in 'Password', with: comment_two.user.password
    click_button 'Sign In'
    visit politicians_path
    click_link(comment_two.politician.full_name)

    click_link "edit-comment-#{comment_two.id}"
    expect(page).to have_content comment_two.body

    fill_in 'comment_body', with: ''
    click_button 'Update Comment'
    expect(page).to have_content '. Comment Not Updated!'
  end

  scenario "they can not update or delete someone else's comment" do
    visit root_path

    click_link 'Sign In'
    fill_in 'Email', with: comment_two.user.email
    fill_in 'Password', with: comment_two.user.password
    click_button 'Sign In'
    visit politicians_path
    click_link(comment_one.politician.full_name)

    expect(page).to have_content 'Rating'
    expect(page).to have_content comment_one.body
    expect(page).to have_content comment_one.rating
    expect(page).to_not have_content 'Edit Comment'
    expect(page).to_not have_content 'Delete Comment'
  end
end
