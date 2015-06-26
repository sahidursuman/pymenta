class AddPaymentsDocumentIdToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :payments_document_id, :string
  end
end
