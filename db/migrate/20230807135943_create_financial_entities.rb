class CreateFinancialEntities < ActiveRecord::Migration[7.0]
  def change
    create_table :financial_entities do |t|
      t.references :author, null: false, foreign_key: {to_table: :users}
      t.string :name
      t.integer :amount,default: 0

      t.timestamps
    end
  end
end
