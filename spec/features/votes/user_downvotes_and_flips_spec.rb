require "rails_helper"
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false)
end

feature "user can downvote and flip their vote on a comment" do
  let!(:comment1) { FactoryGirl.create(:comment) }
  scenario "signed-in user downvotes a comment and is reflected on the page
    without reloading it", js: true do

    visit new_user_session_path

    fill_in 'Email', with: comment1.user.email
    fill_in 'Password', with: comment1.user.password
    click_button 'Sign In'
    visit politicians_path
    click_link comment1.politician.full_name

    find(".arrow-down").click
    within(".upper-#{comment1.id}") { expect(page).to have_content('0') }
    within(".downer-#{comment1.id}") { expect(page).to have_content('1') }
  end

  scenario "signed-in user can flip their upvote to a downvote", js: true do
    visit new_user_session_path

    fill_in 'Email', with: comment1.user.email
    fill_in 'Password', with: comment1.user.password
    click_button 'Sign In'
    visit politicians_path
    click_link comment1.politician.full_name

    find(".arrow-up").click
    within(".upper-#{comment1.id}") { expect(page).to have_content('1') }
    within(".downer-#{comment1.id}") { expect(page).to have_content('0') }

    find(".arrow-up").click
    within(".upper-#{comment1.id}") { expect(page).to have_content('0') }
    within(".downer-#{comment1.id}") { expect(page).to have_content('1') }
  end
end
