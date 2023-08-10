class FinancialGroup < ApplicationRecord
  belongs_to :user
  has_many :categorisations, dependent: :destroy
  has_many :financial_entities,through: :categorisations
  has_one_attached :icon
  validates :name,  presence: true
end
