class CreateServicePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :service_payments, :id => false do |t|
      t.string :id, :limit => 36, :primary => true
      t.string :amount
      t.string :description
      t.string :payment_id
      t.string :state
      t.string :period
      t.string :method
      t.string :domain

      t.timestamps
    end
  end
end
