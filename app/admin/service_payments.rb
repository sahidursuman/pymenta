ActiveAdmin.register ServicePayment do
  form do |f|
    f.inputs do 
      f.input :amount
      f.input :description
      f.input :payment_id
      f.input :state
      f.input :period
      f.input :method   
      f.input :company, label: 'Select a Company:'             
    end

    f.actions
  end  
end