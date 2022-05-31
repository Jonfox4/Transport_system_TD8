class CreateTimeDeliveries < ActiveRecord::Migration[7.0]
  def change
    create_table :time_deliveries do |t|
      t.decimal :min_distance
      t.decimal :max_distance
      t.integer :time
      t.references :shipping_company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
