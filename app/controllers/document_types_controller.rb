class DocumentTypesController < ApplicationController
  # GET /document_types
  # GET /document_types.json
  before_action :authenticate_user!
  def index
    @document_types = current_user.company.document_types

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @document_types }
    end
  end

  # GET /document_types/1
  # GET /document_types/1.json
  def show
    @document_type = DocumentType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @document_type }
    end
  end

  # GET /document_types/new
  # GET /document_types/new.json
  def new
    @document_type = DocumentType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @document_type }
    end
  end

  # GET /document_types/1/edit
  def edit
    @document_type = DocumentType.find(params[:id])
  end

  # POST /document_types
  # POST /document_types.json
  def create
    params[:document_type][:version] = ENV["VERSION"]
    params[:document_type][:domain] = current_user.domain
    params[:document_type][:username] = current_user.username
    @document_type = DocumentType.new(document_type_params)

    respond_to do |format|
      if @document_type.save
        format.html { redirect_to @document_type, notice: 'Document type was successfully created.' }
        format.json { render json: @document_type, status: :created, location: @document_type }
      else
        format.html { render action: "new" }
        format.json { render json: @document_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /document_types/1
  # PUT /document_types/1.json
  def update
    params[:document_type][:version] = ENV["VERSION"]
    params[:document_type][:username] = current_user.username
    @document_type = DocumentType.find(params[:id])

    respond_to do |format|
      if @document_type.update_attributes(document_type_params)
        format.html { redirect_to @document_type, notice: 'Document type was successfully updated.' }
        format.json { render json: @document_type }
      else
        format.html { render action: "edit" }
        format.json { render json: @document_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /document_types/1
  # DELETE /document_types/1.json
  def destroy
    @document_type = DocumentType.find(params[:id])
    @document_type.destroy

    respond_to do |format|
      format.html { redirect_to document_types_url }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document_type
      @document_type = DocumentType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_type_params
      params.require(:document_type).permit(:account_type, :description, :domain, :id, :stock, :stock_type, :username, :version)
    end
end
