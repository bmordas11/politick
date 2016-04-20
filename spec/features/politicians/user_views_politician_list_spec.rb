require 'rails_helper'

feature 'any user can view a list of politicians' do
  let!(:george_clooney) { FactoryGirl.create(:politician) }
  let!(:hillary_clinton) { FactoryGirl.create(:politician) }

  scenario 'sees a list of politicians' do
    visit root_path
    click_link 'All Politicians'

    expect(page).to have_content(george_clooney.full_name)
    expect(page).to have_content(hillary_clinton.full_name)
  end
end
