class CreatePaymentsDocuments < ActiveRecord::Migration
  def change
    create_table :payments_documents do |t|
      t.string :id
      t.string :version
      t.string :domain
      t.string :username
      t.string :type
      t.string :number
      t.date :date
      t.decimal :total
      t.decimal :paid
      t.decimal :paid_left
      t.integer :year
      t.integer :month

      t.timestamps
    end
  end
end
