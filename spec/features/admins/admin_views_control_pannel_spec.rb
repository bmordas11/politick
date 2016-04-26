require 'rails_helper'

feature 'an admin can see their special dashboard' do
  let!(:george_clooney) { FactoryGirl.create(:politician) }
  let!(:hillary_clinton) { FactoryGirl.create(:politician) }
  let!(:bobby_user) { FactoryGirl.create(:user) }
  let!(:user_two) { FactoryGirl.create(:user) }
  let!(:davie_admin) { FactoryGirl.create(:admin) }

  scenario 'sees their dashboard with the information' do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: davie_admin.email
    fill_in 'Password', with: davie_admin.password
    click_button 'Sign In'

    click_link 'Admin Dashboard'

    expect(page).to have_content(george_clooney.full_name)
    expect(page).to have_content(hillary_clinton.full_name)
    expect(page).to have_content(bobby_user.full_name)
    expect(page).to have_content(user_two.full_name)
    expect(page).to have_content(davie_admin.full_name)
  end
end
