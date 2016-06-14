require 'rails_helper'
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false)
end

feature 'user comments on a politician with javascript' do
  let!(:comment)  { FactoryGirl.create(:comment) }

  scenario 'successfully adds a javascript comment', js: true do
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
    find('input#submit-comment').click
    wait_for_ajax

    expect(page).to have_content("This dude is so jacked it's insane!")
    expect(page).to have_content('4')
  end

  scenario 'unsuccessfully adds javascript comment (both fields blank)',
    js: true do
    # visit root_path
    #
    # click_link 'Sign In'
    # fill_in 'Email', with: comment.user.email
    # fill_in 'Password', with: comment.user.password
    # click_button 'Sign In'
    #
    # visit politicians_path
    # click_link(comment.politician.full_name)
    # fill_in 'comment_body', with: "This dude is so jacked it's insane!"
    # click_button 'Add Comment'
    # expect(page).to_not have_content("This dude is so jacked it's insane!")
    # expect(page).to have_content("Rating is not included in the list. Comment not created.")
  end
end
