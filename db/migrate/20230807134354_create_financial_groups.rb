class CreateFinancialGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :financial_groups do |t|
      t.string :name
      t.string :icon

      t.timestamps
    end
  end
end
