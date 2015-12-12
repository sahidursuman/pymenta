ActiveAdmin.register Company do
  form do |f|
    f.inputs do 
      f.input :name 
      f.input :id_number1 
      f.input :address , input_html: { style: "width:50%;" }
      f.input :city 
      f.input :state 
      f.input :country, as: :string 
      f.input :zip_code 
      f.input :telephone 
      f.input :fax
      f.input :email 
      f.input :web 
      f.input :contact 
    end

    f.actions
  end
  index do                            
    column :name
    column :id_number1
    column :city
    column :state
    column :country
    column :plan                     
          
    actions                   
  end
  show do
    panel "Details" do
      table_for company do
        column :name
        column :id_number1
        column :city
        column :state
        column :country
        column :plan
       end
      end    
    panel "Users" do
      table_for company.users do
        column :id
        column :name
        column :email
        column :created_at
      end
    end      
    panel "Service Payments" do
      table_for company.service_payments do
        column :id
        column :payment_id
        column :description
        column :method
        column :period
        column :state
        column :created_at
      end
    end
  end
end

