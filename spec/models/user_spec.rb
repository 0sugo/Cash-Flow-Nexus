require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it 'has many financial_groups' do
      association = described_class.reflect_on_association(:financial_groups)
      expect(association.macro).to eq :has_many
      expect(association.options).to include(dependent: :destroy)
    end

    it 'has many financial_entities with foreign key author_id' do
      association = described_class.reflect_on_association(:financial_entities)
      expect(association.macro).to eq :has_many
      expect(association.options).to include(foreign_key: 'author_id', dependent: :destroy)
    end
  end

  describe 'validations' do
    it 'validates presence of name' do
      user = User.new(email: 'test@example.com', password: 'password123')
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'validates presence of email' do
      user = User.new(name: 'John Doe', password: 'password123')
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'validates presence of password' do
      user = User.new(name: 'John Doe', email: 'test@example.com')
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it 'validates length of password is at least 6 characters' do
      user = User.new(name: 'John Doe', email: 'test@example.com', password: '12345')
      user.valid?
      expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
    end
  end
end
