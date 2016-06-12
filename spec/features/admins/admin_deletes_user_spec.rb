require 'rails_helper'

feature 'an admin can delete a user from the site' do
  let!(:george_clooney) { FactoryGirl.create(:politician) }
  let!(:hillary_clinton) { FactoryGirl.create(:politician) }
  let!(:bobby_user) { FactoryGirl.create(:user, first_name: 'Bobby') }
  let!(:user_two) { FactoryGirl.create(:user, first_name: 'User') }
  let!(:davie_admin) { FactoryGirl.create(:admin) }

  scenario 'admin deletes user successfully' do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: davie_admin.email
    fill_in 'Password', with: davie_admin.password
    click_button 'Sign In'

    click_link 'Admin Dashboard'

    expect(page).to have_content(bobby_user.full_name)
    expect(page).to have_content(user_two.full_name)

    click_button "delete-user-#{user_two.id}"

    expect(page).to have_content(bobby_user.full_name)
    expect(page).to_not have_content(user_two.full_name)
    expect(page).to have_content(davie_admin.full_name)
  end
end
