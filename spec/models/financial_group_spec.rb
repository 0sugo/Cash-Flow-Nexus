require 'rails_helper'

RSpec.describe FinancialGroup, type: :model do
  context 'associations' do
    it 'belongs to a user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it 'has many categorisations with dependent destroy' do
      association = described_class.reflect_on_association(:categorisations)
      expect(association.macro).to eq :has_many
      expect(association.options[:dependent]).to eq :destroy
    end

    it 'has many financial entities through categorisations' do
      association = described_class.reflect_on_association(:financial_entities)
      expect(association.macro).to eq :has_many
      expect(association.options[:through]).to eq :categorisations
    end

    it 'has one attached icon' do
      association = described_class.reflect_on_association(:icon_attachment)
      expect(association.macro).to eq :has_one
    end
  end

  context 'validations' do
    it 'is invalid without a name' do
      file = Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'icon.png'), 'image/png')
      financial_group = FinancialGroup.new(icon: file)
      expect(financial_group).to_not be_valid
      expect(financial_group.errors[:name]).to include("can't be blank")
    end

    context 'validations' do
      it 'is not valid without an icon' do
        financial_group = FinancialGroup.new(name: 'Sample Group')
        expect(financial_group).to_not be_valid
      end
    end
  end
end
