class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :shipping_company, null: false, foreign_key: true
      t.references :vehicle, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.string :customer_address
      t.string :customer_name
      t.date :delivery_date
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
