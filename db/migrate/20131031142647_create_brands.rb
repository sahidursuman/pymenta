class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands, :id => false do |t|
      t.string :id, :limit => 36, :primary => true
      t.string :version
      t.string :domain
      t.string :username
      t.string :code
      t.string :description

      t.timestamps
    end
  end
end
