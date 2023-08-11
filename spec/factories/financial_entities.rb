# spec/factories/financial_entities.rb
FactoryBot.define do
  factory :financial_entity do
    sequence(:name) { |n| "Transaction #{n}" }
    amount { 100 }
    association :author, factory: :user
  end
end
