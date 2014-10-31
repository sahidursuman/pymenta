class AddHeaderIdToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :header_id, :string
  end
end
