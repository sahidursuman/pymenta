class AddWarehouseIdToDocumentLines < ActiveRecord::Migration
  def change
    add_column :document_lines, :warehouse_id, :string
  end
end
