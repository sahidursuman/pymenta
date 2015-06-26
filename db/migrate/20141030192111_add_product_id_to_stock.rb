class AddProductIdToStock < ActiveRecord::Migration
  def change
    add_column :stocks, :product_id, :string
  end
end
