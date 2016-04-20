require 'rails_helper'

feature 'any user can view a politician show page' do
  let!(:politician1)  { FactoryGirl.create(:politician) }

  scenario 'sees information about a politician' do
    visit politicians_path
    click_link politician1.full_name

    expect(page).to have_content(politician1.full_name)
    expect(page).to have_content(politician1.political_party)
    expect(page).to have_content(politician1.place_of_birth)
    expect(page).to have_content(politician1.stance)
    expect(page).to have_content(politician1.birthday)
  end
end
