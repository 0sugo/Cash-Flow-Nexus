class FinancialGroup < ApplicationRecord
  belongs_to :user
  has_many :categorisations, dependent: :destroy
  has_many :financial_entities, through: :categorisations
  attribute :icon, :string, default: 'image upload'
  has_one_attached :icon
  validates :name,:icon, presence: true
end
