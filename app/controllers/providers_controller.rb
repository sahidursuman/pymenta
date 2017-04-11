class ProvidersController < ApplicationController
  # GET /providers
  # GET /providers.json
  before_action :authenticate_user!
  def search
   @providers = Provider.where("domain = ? AND code like ? AND name like ? AND city like ? ", current_user.domain,"%#{params[:code]}%","%#{params[:name]}%","%#{params[:city]}%").paginate(:page => params[:page], :per_page => 10).order('name ASC')
    render :index
  end

  def autocomplete
    @providers = Provider.where("domain = ? AND (code like ? OR name like ?)", current_user.domain,"%#{params[:query]}%","%#{params[:query]}%")

    result = @providers.collect do |item|
      { :value => item.id, :label => item.code + " - " + item.name }
    end
    render json: result
  end

  def index
    @providers = Account.where("domain = ? AND type = ?",current_user.domain,"Provider").paginate(:page => params[:page], :per_page => 10).order('name ASC')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @providers }
      format.js {}
    end
  end

  # GET /providers/1
  # GET /providers/1.json
  def show
    @provider = Provider.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @provider }
    end
  end

  # GET /providers/new
  # GET /providers/new.json
  def new
    @provider = Provider.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @provider }
	    format.js {}      
    end
  end

  # GET /providers/1/edit
  def edit
    @provider = Provider.find(params[:id])
  end

  # POST /providers
  # POST /providers.json
  def create
    params[:provider][:version] = ENV["VERSION"]
    params[:provider][:domain] = current_user.domain
    params[:provider][:username] = current_user.username
    @provider = Provider.new(provider_params)

    respond_to do |format|
      if @provider.save
        format.html { redirect_to @provider, notice: 'Provider was successfully created.' }
        format.json { render json: @provider, status: :created, location: @provider }
        format.js {}
      else
        format.html { render action: "new" }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  # PUT /providers/1
  # PUT /providers/1.json
  def update
    params[:provider][:version] = ENV["VERSION"]
    params[:provider][:domain] = current_user.domain
    @provider = Provider.find(params[:id])

    respond_to do |format|
      if @provider.update_attributes(provider_params)
        format.html { redirect_to @provider, notice: 'Provider was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /providers/1
  # DELETE /providers/1.json
  def destroy
    @provider = Provider.find(params[:id])
    @provider.destroy

    respond_to do |format|
      format.html { redirect_to providers_url }
      format.json { head :no_content }
    end
  end
  
  def get_info_from_selected_account
    @account = Provider.find(params[:provider_id])
    render :partial => "documents/account", :object => @account
  end
  
  def providers_report
    #raise params.inspect
    @user = current_user
    @code = params[:code]
    @name = params[:name]
    @city = params[:city]
    @accounts = Provider.where("domain = ? AND (code like ? OR name like ? OR city like ?)", current_user.domain,"%#{@code}%","%#{@name}%","%#{@city}%") 
    pdf = AccountsReport.new(@accounts, @user, @code, @name, @city)
    send_data pdf.render, filename:'providers_report.pdf',type: 'application/pdf', disposition: 'inline'
  end
  
  def account_report
    #raise params.inspect
    @user = current_user
    @account = Provider.find(params[:id])
    pdf = AccountReport.new(@account, @user)
    send_data pdf.render, filename:'account_report.pdf',type: 'application/pdf', disposition: 'inline'
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_provider
      @provier = Provider.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def provider_params
      params.require(:provider).permit(:address, :balance, :balance_b, :city, :code, :contact, :country, :debit_credit, :domain, :email, :fax, :id, :id_number1, :id_number2, :name, :observations, :state, :telephone, :type, :username, :version, :web, :zip_code)
    end
end
