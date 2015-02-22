class AddAccountIdToPaymentsDocument < ActiveRecord::Migration
  def change
    add_column :payments_documents, :account_id, :string
  end
end
