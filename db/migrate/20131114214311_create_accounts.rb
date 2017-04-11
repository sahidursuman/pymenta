class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts, :id => false do |t|
      t.string :id, :limit => 36, :primary => true
      t.string :version
      t.string :domain
      t.string :username
      t.string :code
      t.string :name
      t.string :type
      t.boolean :debit_credit
      t.decimal :balance, :precision => 10, :scale => 2
      t.decimal :balance_b, :precision => 10, :scale => 2
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
      t.string :contact
      t.string :observations

      t.timestamps
    end
  end
end
