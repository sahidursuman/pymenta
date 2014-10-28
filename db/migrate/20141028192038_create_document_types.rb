class CreateDocumentTypes < ActiveRecord::Migration
  def change
    create_table :document_types, :id => false do |t|
      t.string :id, :limit => 36, :primary => true
      t.string :version
      t.string :domain
      t.string :username
      t.string :description
      t.string :account_type
      t.string :stock_type
      t.boolean :stock

      t.timestamps
    end
  end
end