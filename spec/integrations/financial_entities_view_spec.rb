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
    puts page.body
    expect(page).to have_content(financial_entity.name)
  end
end

describe "Homepage" do
  it "displays the 'ADD' link" do
    visit financial_groups_path
    puts page.body

    expect(page).to have_content("ADD NEW CATEGORY")
  end
end


describe "new" do
    it "displays the new financial entity form" do
      # Create a valid financial group with an ID
      financial_group = FinancialGroup.create(name: 'sample', icon: 'image upload', user_id: @user.id)

      visit new_financial_group_financial_entity_path(financial_group)

      expect(page).to have_content("ADD")
    end
  end



  describe "create" do
    it "creates a new financial entity" do
      financial_group = FinancialGroup.create!(name: "Sample Group", user: user)

      visit new_financial_group_financial_entity_path(financial_group)

      fill_in "Name", with: "Transaction 1"
      fill_in "Amount", with: 100
      click_button "Create Entry"

      expect(page).to have_content("Transaction added successfully.")
    end

    it "renders new template when creation fails" do
      financial_group = FinancialGroup.create!(name: "Sample Group", user: user)

      visit new_financial_group_financial_entity_path(financial_group)

      click_button "Create Entry"

      expect(page).to have_content("ADD")
      expect(page).to have_content("can't be blank")
    end
  end
























  # scenario 'User can view financial entities for a category' do
  #   visit financial_group_financial_entities_path(financial_group)
  #   expect(page).to have_content('No transactions yet')
  # end

  # scenario 'User can add a new transaction' do
  #   visit new_financial_group_financial_entity_path(financial_group)
  #   fill_in 'Name', with: 'Transaction 1'
  #   fill_in 'Amount', with: 100
  #   click_button 'Create Entry'

  #   expect(page).to have_content('Transaction added successfully.')
  #   expect(page).to have_content('Transaction 1')
  # end

  # scenario 'User can view added transaction' do
  #   financial_entity = FinancialEntity.create(name: 'Transaction 1', amount: 100, author: user)
  #   financial_group.financial_entities << financial_entity # Associate the financial entity with the financial group
  #   visit financial_group_financial_entities_path(financial_group)

  #   expect(page).to have_content('Transaction 1')
  #   expect(page).to have_content('100 $')
  # end

  # scenario 'User can view multiple transactions' do
  #   financial_entity1 = FinancialEntity.create(name: 'Transaction 1', amount: 100, author: user)
  #   financial_entity2 = FinancialEntity.create(name: 'Transaction 2', amount: 200, author: user)
  #   Categorisation.create(financial_group:, financial_entity: financial_entity1)
  #   Categorisation.create(financial_group:, financial_entity: financial_entity2)
  #   visit financial_group_financial_entities_path(financial_group)

  #   expect(page).to have_content('Transaction 1')
  #   expect(page).to have_content('Transaction 2')
  # end
end
