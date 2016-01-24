class StocksController < ApplicationController
  # GET /stocks
  # GET /stocks.json
  before_filter :authenticate_user!
  def search
    @warehouse = params[:warehouse_id]
    @description = params[:description]
    @query = "stocks.domain = ? and products.description like ?"
    if !@warehouse.blank? 
      @query = @query + " and warehouse_id = ?"
    else
      @query = @query + " or warehouse_id = ?"
    end
    @stocks = Stock.joins(:product).where(@query , current_user.domain, "%#{@description}%","#{@warehouse}").paginate(:page => params[:page], :per_page => 10).order('description ASC')
    render :index
  end

  def index
    @stocks = current_user.company.stocks.paginate(:page => params[:page], :per_page => 10).order('created_at ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stocks }
    end
  end

  # GET /stocks/1
  # GET /stocks/1.json
  def show
    @stock = Stock.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stock }
    end
  end

  # GET /stocks/new
  # GET /stocks/new.json
  def new
    @stock = Stock.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stock }
    end
  end

  # GET /stocks/1/edit
  def edit
    @stock = Stock.find(params[:id])
  end

  # POST /stocks
  # POST /stocks.json
  def create
    params[:stock][:version] = ENV["VERSION"]
    params[:stock][:domain] = current_user.domain
    params[:stock][:username] = current_user.username
    @stock = Stock.new(params[:stock])

    respond_to do |format|
      if @stock.save
        format.html { redirect_to @stock, notice: 'Stock was successfully created.' }
        format.json { render json: @stock, status: :created, location: @stock }
      else
        format.html { render action: "new" }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stocks/1
  # PUT /stocks/1.json
  def update
    params[:stock][:version] = ENV["VERSION"]
    params[:stock][:username] = current_user.username
    @stock = Stock.find(params[:id])

    respond_to do |format|
      if @stock.update_attributes(params[:stock])
        format.html { redirect_to @stock, notice: 'Stock was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stocks/1
  # DELETE /stocks/1.json
  def destroy
    @stock = Stock.find(params[:id])
    @stock.destroy

    respond_to do |format|
      format.html { redirect_to stocks_url }
      format.json { head :no_content }
    end
  end
end
