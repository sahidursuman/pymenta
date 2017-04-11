class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories, :id => false do |t|
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
