class AddAccountIdToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :account_id, :string
  end
end
