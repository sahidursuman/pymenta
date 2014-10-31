class AddDocumentTypeIdToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :document_type_id, :string
  end
end
