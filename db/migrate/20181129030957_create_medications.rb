class CreateMedications < ActiveRecord::Migration[5.1]
  def change
    create_table :medications do |t|
      t.string :name
      t.integer :med_type_id

      t.timestamps
    end
  end
end
