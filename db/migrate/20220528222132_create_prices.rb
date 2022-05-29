class CreatePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :prices do |t|
      t.decimal :minimum_weight
      t.decimal :maximum_weight
      t.decimal :maximum_cubic_meter
      t.decimal :minimum_cubic_meter
      t.decimal :price_km
      t.references :shipping_company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
