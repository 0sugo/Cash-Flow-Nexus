require 'rails_helper'

FactoryBot.define do
  factory :financial_group do
    sequence(:name) { |n| "Group #{n}" }
    icon { 'image upload' }
    association :user, factory: :user
  end
end
