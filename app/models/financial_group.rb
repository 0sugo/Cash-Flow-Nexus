class FinancialGroup < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :financial_entities

  validates :name, presence: true
  validates :icon, presence: true
end
