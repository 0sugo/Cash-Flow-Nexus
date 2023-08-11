require 'rails_helper'

RSpec.feature 'Financial Groups', type: :feature do
  before(:each) do
    @user = User.create!(name: Faker::Name.unique.name,
                         email: Faker::Internet.email,
                         password: '1234567', password_confirmation: '1234567')

    @financial_group = FinancialGroup.create(name: 'house', icon: nil, user_id: @user.id)
    login_as(@user, scope: :user)
  end

  scenario 'User can visit the index page' do
    visit financial_groups_path
    expect(page).to have_content('Here are your categories')
  end

  scenario 'User can add a new category' do
    visit new_financial_group_path

    fill_in 'Name', with: 'New Category'
    attach_file('Icon', Rails.root.join('spec', 'fixtures', 'sample-icon.png'))

    click_button 'Create entry'

    expect(page).to have_content('New Category')
    expect(page).to have_css('.category-card', count: 1, text: 'New Category')
  end
end
