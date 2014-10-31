class AddHeaderIdToDocumentLines < ActiveRecord::Migration
  def change
    add_column :document_lines, :header_id, :string
  end
end
