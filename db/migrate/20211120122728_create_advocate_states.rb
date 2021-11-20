class CreateAdvocateStates < ActiveRecord::Migration[6.1]
  def change
    create_table :advocate_states do |t|

      t.references :advocate, foreign_key: true
      t.references :state, foreign_key: true
      t.timestamps
    end
  end
end
