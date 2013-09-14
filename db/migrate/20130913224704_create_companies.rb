class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies, :id => false do |t|
      t.string :id, :limit => 36, :primary => true
      t.string :name
      t.string :address

      t.timestamps
    end
  end
end
