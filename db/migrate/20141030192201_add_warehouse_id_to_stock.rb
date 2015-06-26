class AddWarehouseIdToStock < ActiveRecord::Migration
  def change
    add_column :stocks, :warehouse_id, :string
  end
end
