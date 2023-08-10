class CreateCategorisations < ActiveRecord::Migration[7.0]
  def change
    create_table :categorisations do |t|
      t.references :financial_group, null: false, foreign_key: true
      t.references :financial_entity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
