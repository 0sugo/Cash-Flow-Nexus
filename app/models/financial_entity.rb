class FinancialEntity < ApplicationRecord
  belongs_to :author
  belongs_to :financial_group
end
