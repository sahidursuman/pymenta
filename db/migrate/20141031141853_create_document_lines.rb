class CreateDocumentLines < ActiveRecord::Migration
  def change
    create_table :document_lines do |t|
      t.string :id
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

      t.timestamps
    end
  end
end
