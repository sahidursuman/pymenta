class AddPaymentsDocumentIdToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :payments_document_id, :string
  end
end
