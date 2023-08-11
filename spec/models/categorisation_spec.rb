require 'rails_helper'

RSpec.describe Categorisation, type: :model do
  describe 'associations' do
    it 'belongs to a financial group' do
      association = described_class.reflect_on_association(:financial_group)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to a financial entity' do
      association = described_class.reflect_on_association(:financial_entity)
      expect(association.macro).to eq :belongs_to
    end
  end
end
