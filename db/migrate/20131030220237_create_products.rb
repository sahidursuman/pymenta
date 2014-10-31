class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products, :id => false do |t|
      t.string :id, :limit => 36, :primary => true
      t.string :version
      t.string :domain
      t.string :username
      t.string :code
      t.string :description
      t.string :units
      t.decimal :price, :precision => 10, :scale => 2

      t.timestamps
    end
  end
end
