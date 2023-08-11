require 'rails_helper'

RSpec.describe 'Financial Entities', type: :feature do

  before(:each) do
  @user = User.create!(name: Faker::Name.unique.name,
                       email: Faker::Internet.email,
                       password: '1234567', password_confirmation: '1234567')

  @financial_group = FinancialGroup.create(name: 'house', user_id: @user.id)
  icon_path = Rails.root.join('app', 'assets', 'images', 'icon.png')
  @financial_group.icon.attach(io: File.open(icon_path), filename: 'icon.png', content_type: 'image/png')
  login_as(@user, scope: :user)
end

describe "index" do
  it "displays the list of financial entities" do
    financial_entity = FinancialEntity.create!(name: "Transaction 1", amount: 100, author: @user)
    categori = Categorisation.create!(financial_entity: financial_entity, financial_group: @financial_group)

    visit financial_group_financial_entities_path(@financial_group)
    expect(page).to have_content(financial_entity.name)
  end
end

describe "Homepage" do
  it "displays the 'ADD' link" do
    visit financial_groups_path
    expect(page).to have_content("ADD NEW CATEGORY")
  end
end
end
