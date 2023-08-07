class FinancialGroup < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :financial_entities
end
