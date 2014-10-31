class AddWarehouseIdToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :warehouse_id, :string
  end
end
