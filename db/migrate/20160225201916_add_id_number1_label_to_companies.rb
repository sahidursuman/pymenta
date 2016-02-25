class AddIdNumber1LabelToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :id_number1_label, :string
  end
end
