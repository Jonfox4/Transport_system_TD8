class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :plate
      t.string :brand
      t.string :vehicle_model
      t.integer :fabrication_year
      t.references :shipping_company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
