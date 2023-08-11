class CreateFinancialGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :financial_groups do |t|
      t.string :name
      t.string :icon
      t.references :user,null: false,foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
