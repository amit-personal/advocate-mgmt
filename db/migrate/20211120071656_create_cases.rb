class CreateCases < ActiveRecord::Migration[6.1]
  def change
    create_table :cases do |t|

      t.string :name
      t.boolean :is_active, default: true
      t.references :advocate, foreign_key: true
      t.references :state, foreign_key: true
      t.timestamps
    end
  end
end
