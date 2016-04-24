require 'rails_helper'

feature 'user comments on a politician' do
  let!(:comment)  { FactoryGirl.create(:comment) }

  scenario 'successfully adds a comment' do
    visit root_path

    click_link 'Sign In'
    fill_in 'Email', with: comment.user.email
    fill_in 'Password', with: comment.user.password
    click_button 'Sign In'
    visit politicians_path
    click_link(comment.politician.full_name)

    fill_in 'comment_body', with: "This dude is so jacked it's insane!"
    expect(page).to have_content('Rating')
    choose('4')
    click_button 'Add Comment'
    expect(page).to have_content("This dude is so jacked it's insane!")
    expect(page).to have_content('4')
    expect(page).to have_content('Successfully added comment.')
  end

  scenario 'unsuccessfully adds a comment (both fields blank)' do
    visit root_path

    click_link 'Sign In'
    fill_in 'Email', with: comment.user.email
    fill_in 'Password', with: comment.user.password
    click_button 'Sign In'

    visit politicians_path
    click_link(comment.politician.full_name)
    fill_in 'comment_body', with: "This dude is so jacked it's insane!"
    click_button 'Add Comment'
    expect(page).to_not have_content("This dude is so jacked it's insane!")
    expect(page).to have_content("Rating is not included in the list. Comment not created.")
  end
end
