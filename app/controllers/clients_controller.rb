class ClientsController < ApplicationController
  # GET /clients
  # GET /clients.json
  before_filter :authenticate_user!
  def search
   @clients = Client.where("domain = ? AND code like ? AND name like ? AND city like ? ", current_user.domain,"%#{params[:code]}%","%#{params[:name]}%","%#{params[:city]}%").paginate(:page => params[:page], :per_page => 10).order('name ASC')
    render :index
  end

  def autocomplete
    @clients = Client.where("domain = ? AND (code like ? OR name like ?)", current_user.domain,"%#{params[:query]}%","%#{params[:query]}%")

    result = @clients.collect do |item|
      { :value => item.id, :label => item.code + " - " + item.name }
    end
    render json: result
  end

  def index
    @clients = Account.where("domain = ? AND type = ?",current_user.domain,"Client").paginate(:page => params[:page], :per_page => 10).order('name ASC')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clients }
      format.js {}
    end
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    @client = Client.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @client }
    end
  end

  # GET /clients/new
  # GET /clients/new.json
  def new
    @client = Client.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @client }
	    format.js {}
    end
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])
  end

  # POST /clients
  # POST /clients.json
  def create
    params[:client][:version] = ENV["VERSION"]
    params[:client][:domain] = current_user.domain
    params[:client][:username] = current_user.username
    @client = Client.new(params[:client])

    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: 'Client was successfully created.' }
        format.json { render json: @client, status: :created, location: @client }
        format.js {}
      else
        format.html { render action: "new" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  # PUT /clients/1
  # PUT /clients/1.json
  def update
    params[:client][:version] = ENV["VERSION"]
    params[:client][:username] = current_user.username
    @client = Client.find(params[:id])

    respond_to do |format|
      if @client.update_attributes(params[:client])
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    respond_to do |format|
      format.html { redirect_to clients_url }
      format.json { head :no_content }
    end
  end
  
  def get_info_from_selected_account
    @account = Client.find(params[:client_id])
    render :partial => "documents/account", :object => @account
  end

  def clients_report
    #raise params.inspect
    @user = current_user
    @code = params[:code]
    @name = params[:name]
    @city = params[:city]
    @clients = Client.where("domain = ? AND (code like ? OR name like ? OR city like ?)", current_user.domain,"%#{@code}%","%#{@name}%","%#{@city}%") 
    pdf = ProvidersReport.new(@clients, @user, @code, @name, @city)
    send_data pdf.render, filename:'clients_report.pdf',type: 'application/pdf', disposition: 'inline'
  end
  
  def account_report
    #raise params.inspect
    @user = current_user
    @account = Client.find(params[:id])
    pdf = AccountReport.new(@account, @user)
    send_data pdf.render, filename:'account_report.pdf',type: 'application/pdf', disposition: 'inline'
  end
end
