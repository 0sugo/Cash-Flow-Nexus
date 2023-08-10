class Categorisation < ApplicationRecord
  belongs_to :financial_group
  belongs_to :financial_entity

end
