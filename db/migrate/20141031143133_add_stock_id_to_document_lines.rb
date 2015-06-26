class AddStockIdToDocumentLines < ActiveRecord::Migration
  def change
    add_column :document_lines, :stock_id, :string
  end
end
