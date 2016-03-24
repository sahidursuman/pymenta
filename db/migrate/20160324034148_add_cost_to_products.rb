class AddCostToProducts < ActiveRecord::Migration
  def change
    add_column :products, :cost, :decimal, :precision => 10, :scale => 2
  end
end
