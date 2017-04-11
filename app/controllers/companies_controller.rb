class CompaniesController < ApplicationController
  # GET /companies
  # GET /companies.json
  before_action :authenticate_user!
  def index
#    @companies = Company.all
    @company = Company.find(current_user.company.id)

    respond_to do |format|
      format.html { redirect_to @company }
      format.json { render json: @company }
    end
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    @company = Company.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company }
    end
  end

  # GET /companies/new
  # GET /companies/new.json
  def new
    @company = Company.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @company }
    end
  end

  # GET /companies/1/edit
  def edit
    @company = Company.find(params[:id])
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /companies/1/edit
  def edit_formats
    @company = Company.find(params[:id])
    respond_to do |format|
      format.js
      format.html
    end
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render json: @company, status: :created, location: @company }
      else
        format.html { render action: "new" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.json
  def update
    @company = Company.find(params[:id])

    respond_to do |format|
      if @company.update_attributes(company_params)
        format.js do
          if params[:update_formats]
            render 'update_formats'
          else
            render 'update'
          end
        end
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { head :no_content }
      else
        format.js { render action: "edit" }
        format.html { render action: "edit" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.html { redirect_to companies_url }
      format.json { head :no_content }
    end
  end
  

  def upload_logo
    @company = current_user.company
    @company.logo = params[:logo]
    @logo_uploaded = @company.save
  end

  def delete_logo
    @company = current_user.company
    @company.logo = nil
    @company.save
  end

   # ############# Para Pruebas 
   #  def became_free
   #     @company = Company.find(current_user.company.id)
   #     @company.plan = "GRATIS"
   #     @company.initial_cycle = Time.new
   #     @company.final_cycle = Time.now.months_since(1)
   #     @company.counter = 0
   #     @company.limit = 3
   #     
   #     respond_to do |format|
   #        if @company.save
   #    	    format.js { @company.errors[:base] << "SE puso gratis" } 
   #        else
   #          format.js { @company.errors[:base] << "Error al actualizar plan"} 
   #        end
   #      end
   #   end
   ####################   

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:id, :name, :address, :id_number1, :id_number2, :address, :city, :state, :country, :zip_code, :telephone, :fax, :email, :web, :contact, :initial_cycle, :final_cycle, :plan, :counter, :limit, :note, :date_format, :unit, :separator, :delimiter, :id_number1_label)
    end
end
