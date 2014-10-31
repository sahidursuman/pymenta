class AddProductIdToDocumentLines < ActiveRecord::Migration
  def change
    add_column :document_lines, :product_id, :string
  end
end
