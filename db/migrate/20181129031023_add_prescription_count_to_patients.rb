class AddPrescriptionCountToPatients < ActiveRecord::Migration[5.1]
  def change
    add_column :patients, :prescriptions_count, :integer
  end
end
