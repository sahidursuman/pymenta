class CreateStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :stocks, :id => false do |t|
      t.string :id, :limit => 36, :primary => true
      t.string :version
      t.string :domain
      t.string :username
      t.decimal :in_quantity
      t.decimal :out_quantity
      t.decimal :stock
      t.string :product_id
      t.string :warehouse_id

      t.timestamps
    end
  end
end
