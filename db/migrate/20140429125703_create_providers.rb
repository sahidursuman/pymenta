class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :id
      t.string :name

      t.timestamps
    end
  end
end
