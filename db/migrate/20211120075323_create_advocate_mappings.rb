class CreateAdvocateMappings < ActiveRecord::Migration[6.1]
  def change
    create_table :advocate_mappings do |t|

      t.integer :senior_id
      t.integer :junior_id
      t.timestamps
    end
  end
end
