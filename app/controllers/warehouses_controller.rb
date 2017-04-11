class WarehousesController < ApplicationController
  # GET /warehouses
  # GET /warehouses.json
  before_action :authenticate_user!
  def index
    @warehouses = Account.where("domain = ? AND type = ?",current_user.domain,"Warehouse").paginate(:page => params[:page], :per_page => 10).order('name ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @warehouses }
      format.js {}
    end
  end
  
  def autocomplete
    @warehouses = Warehouse.where("domain = ? AND (code like ? OR name like ?)", current_user.domain,"%#{params[:query]}%","%#{params[:query]}%")

    result = @warehouses.collect do |item|
      { :value => item.id, :label => item.code + " - " + item.name }
    end
    render json: result
  end

  # GET /warehouses/1
  # GET /warehouses/1.json
  def show
    @warehouse = Warehouse.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @warehouse }
    end
  end

  # GET /warehouses/new
  # GET /warehouses/new.json
  def new
    @warehouse = Warehouse.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @warehouse }
      format.js {}
    end
  end

  # GET /warehouses/1/edit
  def edit
    @warehouse = Warehouse.find(params[:id])
  end

  # POST /warehouses
  # POST /warehouses.json
  def create
    params[:warehouse][:version] = ENV["VERSION"]
    params[:warehouse][:domain] = current_user.domain
    params[:warehouse][:username] = current_user.username
    @warehouse = Warehouse.new(warehouse_params)

    respond_to do |format|
      if @warehouse.save
        format.html { redirect_to @warehouse, notice: 'Warehouse was successfully created.' }
        format.json { render json: @warehouse, status: :created, location: @warehouse }
        format.js {}        
      else
        format.html { render action: "new" }
        format.json { render json: @warehouse.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  # PUT /warehouses/1
  # PUT /warehouses/1.json
  def update
    params[:warehouse][:version] = ENV["VERSION"]
    params[:warehouse][:domain] = current_user.domain
    @warehouse = Warehouse.find(params[:id])

    respond_to do |format|
      if @warehouse.update_attributes(warehouse_params)
        format.html { redirect_to @warehouse, notice: 'Warehouse was successfully updated.' }
        format.json { render json: @warehouse }
      else
        format.html { render action: "edit" }
        format.json { render json: @warehouse.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /warehouses/1
  # DELETE /warehouses/1.json
  def destroy
    @warehouse = Warehouse.find(params[:id])
    @warehouse.destroy

    respond_to do |format|
      format.html { redirect_to warehouses_url }
      format.json { head :no_content }
    end
  end
  
  def get_info_from_selected_account
    @account = Warehouse.find(params[:warehouse_id])
    render :partial => "documents/account", :object => @account
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_warehouse
      @warehouse = Warehouse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def warehouse_params
      params.require(:warehouse).permit(:address, :balance, :balance_b, :city, :code, :contact, :country, :debit_credit, :domain, :email, :fax, :id, :id_number1, :id_number2, :name, :observations, :state, :telephone, :type, :username, :version, :web, :zip_code)
    end
end
