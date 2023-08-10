require 'rails_helper'

RSpec.describe 'Financial Entities', type: :feature do
  let(:user) { User.create(email: 'test@example.com', password: 'password', name: 'Test User') }
  let!(:financial_group) { FinancialGroup.create(name: 'Test Category', user:) }

  before do
    login_as(user, scope: :user)
  end

  scenario 'User can view financial entities for a category' do
    visit financial_group_financial_entities_path(financial_group)
    expect(page).to have_content('No transactions yet')
  end

  scenario 'User can add a new transaction' do
    visit new_financial_group_financial_entity_path(financial_group)
    fill_in 'Name', with: 'Transaction 1'
    fill_in 'Amount', with: 100
    click_button 'Create Entry'

    expect(page).to have_content('Transaction added successfully.')
    expect(page).to have_content('Transaction 1')
  end

  scenario 'User can view added transaction' do
    financial_entity = FinancialEntity.create(name: 'Transaction 1', amount: 100, author: user)
    financial_group.financial_entities << financial_entity # Associate the financial entity with the financial group
    visit financial_group_financial_entities_path(financial_group)

    expect(page).to have_content('Transaction 1')
    expect(page).to have_content('100 $')
  end

  scenario 'User can view multiple transactions' do
    financial_entity1 = FinancialEntity.create(name: 'Transaction 1', amount: 100, author: user)
    financial_entity2 = FinancialEntity.create(name: 'Transaction 2', amount: 200, author: user)
    Categorisation.create(financial_group:, financial_entity: financial_entity1)
    Categorisation.create(financial_group:, financial_entity: financial_entity2)
    visit financial_group_financial_entities_path(financial_group)

    expect(page).to have_content('Transaction 1')
    expect(page).to have_content('Transaction 2')
  end
end
