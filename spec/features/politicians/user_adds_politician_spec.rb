require 'rails_helper'

feature 'user adds a new politician' do
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'successfully adds a politician to the website' do
    visit root_path

    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    visit root_path
    click_link 'List a New Politician'

    fill_in('First Name', with: 'Edward')
    fill_in('Last Name', with: 'Cullen')
    fill_in('Political Party', with: 'Green Party')
    fill_in('Place of Birth', with: 'Vancouver, Canada')
    fill_in('Stance', with: 'Lets do some good things today.')
    fill_in('Birthday', with: '1903-11-22')
    click_button 'Add Politician'

    expect(page).to have_content('Edward Cullen')
    expect(page).to have_content('Green Party')
    expect(page).to have_content('Vancouver, Canada')
    expect(page).to have_content('Lets do some good things today.')
    expect(page).to have_content('1903-11-22')
  end

  scenario 'unsuccessfully adds a politician to the website (errors)' do
    visit root_path

    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    visit root_path
    click_link 'List a New Politician'

    fill_in('Place of Birth', with: 'Vancouver, Canada')
    fill_in('Birthday', with: '1903-11-22')
    click_button 'Add Politician'

    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("First name is too short")
    expect(page).to have_content("Last name can't be blank")
    expect(page).to have_content("Last name is too short")
    expect(page).to have_content("Political party can't be blank")
    expect(page).to have_content('New Politician Page')
    expect(page).to have_field('First Name')
    expect(page).to have_field('Last Name')
    expect(page).to have_field('Political Party')
  end
end
