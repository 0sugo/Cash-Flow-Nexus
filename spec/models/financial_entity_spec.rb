require 'rails_helper'

RSpec.describe FinancialEntity, type: :model do
  describe 'associations' do
    it 'belongs to an author' do
      association = described_class.reflect_on_association(:author)
      expect(association.macro).to eq :belongs_to
      expect(association.options[:class_name]).to eq 'User'
    end

    it 'has many categories with dependent destroy' do
      association = described_class.reflect_on_association(:categories)
      expect(association.macro).to eq :has_many
      expect(association.options[:dependent]).to eq :destroy
    end

    it 'has many financial_groups through categorisations' do
      association = described_class.reflect_on_association(:financial_groups)
      expect(association.macro).to eq :has_many
      expect(association.options[:through]).to eq :categorisations
    end
  end

  describe 'validations' do
    it 'validates presence of name' do
      financial_entity = FinancialEntity.new(name: nil)
      financial_entity.valid?
      expect(financial_entity.errors[:name]).to include("can't be blank")
    end

    it 'validates presence and numericality of amount' do
      financial_entity = FinancialEntity.new(amount: nil)
      financial_entity.valid?
      expect(financial_entity.errors[:amount]).to include("can't be blank")

      financial_entity.amount = 'not a number'
      financial_entity.valid?
      expect(financial_entity.errors[:amount]).to include('is not a number')

      financial_entity.amount = -1
      financial_entity.valid?
      expect(financial_entity.errors[:amount]).to include('must be greater than or equal to 0')
    end
  end
end
