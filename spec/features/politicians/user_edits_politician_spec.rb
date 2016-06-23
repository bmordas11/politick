require 'rails_helper'

feature "User can edit his own politician if authenticated" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:politician) { FactoryGirl.create(:politician) }
  scenario "user successfuly edits a politician" do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: politician.user.email
    fill_in 'Password', with: politician.user.password
    click_button 'Sign In'

    visit root_path
    click_link politician.full_name

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
  scenario "user unsuccessfuly edits a politician (errors thrown)" do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: politician.user.email
    fill_in 'Password', with: politician.user.password
    click_button 'Sign In'

    visit root_path
    click_link politician.full_name

    click_button 'Edit'
    fill_in('First Name', with: '')
    fill_in('Last Name', with: '')
    fill_in('Political Party', with: '')
    fill_in('Place of Birth', with: '')
    fill_in('Stance', with: '')
    fill_in('Birthday', with: '')

    click_on "Update Politician"

    expect(page).to have_content('Last name is too short')
    expect(page).to have_content('Political party is too short')
    expect(page).to have_content("Stance can't be blank.")
    expect(page).to have_content('Politician not updated.')
  end
end
