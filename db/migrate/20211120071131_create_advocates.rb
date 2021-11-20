class CreateAdvocates < ActiveRecord::Migration[6.1]
  def change
    create_table :advocates do |t|

      t.references :user, foreign_key: true
      t.references :role, foreign_key: true
      
      t.timestamps
    end
  end
end
