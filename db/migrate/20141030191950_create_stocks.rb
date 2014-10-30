class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks, :id => false do |t|
      t.string :id, :limit => 36, :primary => true
      t.string :version
      t.string :domain
      t.string :username
      t.decimal :in_quantity
      t.decimal :out_quantity
      t.decimal :stock

      t.timestamps
    end
  end
end
