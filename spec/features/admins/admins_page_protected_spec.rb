require 'rails_helper'

feature 'user adds a new politician' do
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'successfully adds a politician to the website' do
    visit root_path

    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    visit admins_path
    expect(page).to have_content('Politicians Index')
    expect(page).to have_content('Unauthorized to enter this page.')
  end
end
