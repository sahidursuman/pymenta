ActiveAdmin.register User do
  form do |f|
    f.inputs do 
      f.input :name 
      f.input :email
    end

    f.actions
  end  
end  