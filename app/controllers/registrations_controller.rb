class RegistrationsController < Devise::RegistrationsController
  before_filter:authenticate_user!, :only => :token
  
  def new
    super
  end
  
  def create
    @company = Company.new(:name => params[:user][:company_name])
    @user = User.new(params[:user])
    User.transaction do
       @company.save!
       @user.domain = @company.id
       @user.save
    end

    if @user.save && @company.save
      sign_in(resource_name, resource)
      defaults @company,@user 
      flash[:notice] = "You have signed up successfully. If enabled, a confirmation was sent to your email"
        redirect_to documents_url
    else
      render :action => :new
    end
  end
  
  def update
    super
  end
  
  def defaults company,user
    brand = Brand.new(:code => '00', :description => 'NONE/NINGUNO', :domain => company.id, :username => user.username).save
    category = Category.new(:code => '00', :description => 'NONE/NINGUNO', :domain => company.id, :username => user.username).save
    warehouse = Warehouse.new(:code => '01', :name => 'MAIN/PRINCIPAL', :domain => company.id, :username => user.username).save
    document_type_1 = DocumentType.new(:description => 'INVOICE/FACTURA', :account_type => 'Client', :stock => true, :stock_type => 'debit', :domain => company.id, :username => user.username).save 
    document_type_2 = DocumentType.new(:description => 'ESTIMATE/PRESUPUESTO', :account_type => 'Client', :stock => false, :stock_type => 'debit', :domain => company.id, :username => user.username).save 
    document_type_3 = DocumentType.new(:description => 'IN STOCK/ENTRADA', :account_type => 'Warehouse', :stock => true, :stock_type => 'credit', :domain => company.id, :username => user.username).save     
  end  
end
            