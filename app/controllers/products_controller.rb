class ProductsController < ApplicationController
  # GET /products
  # GET /products.json
  before_action :authenticate_user!
  def search
    @category = params[:category_id]
    @brand = params[:brand_id]
    @query = "domain = ? and code like ? and description like ? and brand_id like ? and category_id like ?"
    @products = Product.where(@query , current_user.domain, "%#{params[:code]}%","%#{params[:description]}%","%#{params[:brand_id]}%","%#{params[:category_id]}%").paginate(:page => params[:page], :per_page => 10).order('description ASC')
    render :index
  end

  def autocomplete
    @products = Product.where("domain = ? AND (code like ? OR description like ?)", current_user.domain,"%#{params[:query]}%","%#{params[:query]}%")

    result = @products.collect do |item|
      { :value => item.id, :label => item.code + " - " + item.description }
    end
    render json: result
  end
 
  def index
    @products = current_user.company.products.paginate(:page => params[:page], :per_page => 10).order('description ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
      format.js {}
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
	    format.js {}
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    params[:product][:version] = ENV["VERSION"]
    params[:product][:domain] = current_user.domain
    params[:product][:username] = current_user.username
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
        format.js {}
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    params[:product][:version] = ENV["VERSION"]
    params[:product][:username] = current_user.username    
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  def get_info_from_selected_product
    @product = Product.find(params[:product_id])
    render :partial => "documents/product", :object => @product
  end
  
  def product_list_report
    products = current_user.company.products
    user = current_user
    pdf = ProductListReport.new(products, user)
    send_data pdf.render, filename:'product_list_report.pdf',type: 'application/pdf', disposition: 'inline'
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:code, :domain, :description, :id, :price, :units, :username, :version, :brand_id, :category_id, :barcode, :cost)
    end
end
