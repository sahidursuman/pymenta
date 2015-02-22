class AddDocumentTypeIdToPaymentsDocument < ActiveRecord::Migration
  def change
    add_column :payments_documents, :document_type_id, :string
  end
end
