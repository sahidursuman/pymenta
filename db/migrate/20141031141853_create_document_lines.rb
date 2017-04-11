class CreateDocumentLines < ActiveRecord::Migration[5.0]
  def change
    create_table :document_lines, :id => false do |t|
      t.string :id, :limit => 36, :primary => true
      t.string :version
      t.string :domain
      t.string :username
      t.string :code
      t.string :document_number
      t.string :type
      t.string :description
      t.date :date
      t.decimal :in_quantity, :precision => 10, :scale => 2
      t.decimal :out_quantity, :precision => 10, :scale => 2
      t.decimal :price, :precision => 10, :scale => 2
      t.decimal :total, :precision => 10, :scale => 2
      t.integer :year
      t.integer :month
      
      t.string :header_id
      t.string :product_id
      t.string :warehouse_id
      t.string :stock_id

      t.timestamps
    end
  end
end
