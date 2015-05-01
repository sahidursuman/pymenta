class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents, :id => false do |t|
      t.string :id, :limit => 36, :primary => true
      t.string :version
      t.string :domain
      t.string :username
      t.string :code
      t.string :document_number
      t.string :type
      t.string :due
      t.string :status
      t.string :details

      t.date :date
      t.date :expire_date

      t.decimal :discount_percentage, :precision => 10, :scale => 2
      t.decimal :discount_total, :precision => 10, :scale => 2
      t.decimal :sub_total, :precision => 10, :scale => 2
      t.decimal :tax, :precision => 10, :scale => 2
      t.decimal :tax_total, :precision => 10, :scale => 2
      t.decimal :total, :precision => 10, :scale => 2
      t.decimal :paid_left, :precision => 10, :scale => 2
      t.decimal :paid, :precision => 10, :scale => 2

      t.integer :year
      t.integer :month

      t.timestamps
    end
  end
end
