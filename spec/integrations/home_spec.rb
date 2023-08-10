require 'rails_helper'

RSpec.describe 'Home Page', type: :system do
  it 'displays the logo' do
    visit root_path
    expect(page).to have_css('.logo-container')
  end

  it 'displays sign-up links' do
    visit root_path
    expect(page).to have_css('.sign-links')

    within '.sign-links' do
      expect(page).to have_link('LOG IN', href: new_user_session_path, class: 'sign-up a-tag')
      expect(page).to have_link('SIGN UP', href: new_user_registration_path, class: 'sign-up a-tag')
    end
  end
end
