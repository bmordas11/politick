require 'rails_helper'

feature 'a politician may edit the page about them' do
  let!(:politician1) { FactoryGirl.create(:politician) }
  let!(:user2) { FactoryGirl.create(:user, role: 'politician') }
  scenario 'politician user successfully edits show page about them' do
    visit root_path
    politician1.actually_them = user2.id
    politician1.save!

    click_link 'Sign In'
    fill_in 'Email', with: user2.email
    fill_in 'Password', with: user2.password
    click_button 'Sign In'

    visit root_path
    click_link politician1.full_name

    click_button 'Edit'
    fill_in('First Name', with: 'Patricia')
    fill_in('Last Name', with: 'Cohen')
    fill_in('Political Party', with: 'Democrat')
    fill_in('Place of Birth', with: 'Worcester, England')
    fill_in('Stance', with: 'Which ones? Hillary is a liar.')
    fill_in('Birthday', with: '1985-11-22')

    click_on "Update Politician"

    expect(page).to have_content('Patricia Cohen')
    expect(page).to have_content('Democrat')
    expect(page).to have_content('Worcester, England')
    expect(page).to have_content('Which ones? Hillary is a liar.')
    expect(page).to have_content('1985-11-22')
  end
end
