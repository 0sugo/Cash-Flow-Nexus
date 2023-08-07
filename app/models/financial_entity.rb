class FinancialEntity < ApplicationRecord
  belongs_to :author
  belongs_to :financial_group

  validates :name, presence: true
  validates :amount, presence: true, numericality: { only_integer:true, greater_than_or_equal_to:0 }
end
