# spec/factories/categorisations.rb
FactoryBot.define do
  factory :categorisation do
    association :financial_entity
    association :financial_group
  end
end
