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
      flash[:notice] = "You have signed up successfully. If enabled, a confirmation was sent to your email"
        redirect_to users_url
    else
      render :action => :new
    end
  end
  
  def update
    super
  end
end
            