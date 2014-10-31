class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :id
      t.string :version
      t.string :domain
      t.string :username
      t.string :code
      t.string :document_number
      t.string :type
      t.string :name
      t.string :id_number1
      t.string :id_number2
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.string :zip_code
      t.string :telephone
      t.string :fax
      t.string :email
      t.string :web
      t.string :observations
      t.string :due
      t.string :status

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
