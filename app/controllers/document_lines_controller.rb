class DocumentLinesController < ApplicationController
  # GET /document_lines
  # GET /document_lines.json
  before_action :authenticate_user!
  def index
    @document_lines = current_user.company.document_lines.paginate(:page => params[:page], :per_page => 10).order('description ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @document_lines }
    end
  end

  # GET /document_lines/1
  # GET /document_lines/1.json
  def show
    @document_line = DocumentLine.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @document_line }
    end
  end

  # GET /document_lines/new
  # GET /document_lines/new.json
  def new
    @document_line = DocumentLine.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @document_line }
    end
  end

  # GET /document_lines/1/edit
  def edit
    @document_line = DocumentLine.find(params[:id])
  end

  # POST /document_lines
  # POST /document_lines.json
  def create
    params[:document_line][:version] = ENV["VERSION"]
    params[:document_line][:domain] = current_user.domain
    params[:document_line][:username] = current_user.username
    @document_line = DocumentLine.new(document_line_params)

    respond_to do |format|
      if @document_line.save
        format.html { redirect_to @document_line, notice: 'Document line was successfully created.' }
        format.json { render json: @document_line, status: :created, location: @document_line }
      else
        format.html { render action: "new" }
        format.json { render json: @document_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /document_lines/1
  # PUT /document_lines/1.json
  def update
    params[:document_line][:version] = ENV["VERSION"]
    params[:document_line][:username] = current_user.username
    @document_line = DocumentLine.find(params[:id])

    respond_to do |format|
      if @document_line.update_attributes(document_line_params)
        format.html { redirect_to @document_line, notice: 'Document line was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @document_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /document_lines/1
  # DELETE /document_lines/1.json
  def destroy
    @document_line = DocumentLine.find(params[:id])
    @document_line.destroy

    respond_to do |format|
      format.html { redirect_to document_lines_url }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document_line
      @document_line = DocumentLine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_line_params
      params.require(:document_line).permit(:code, :date, :description, :document_number, :domain, :id, :in_quantity, :month, :out_quantity, :price,
   :total, :type, :username, :version, :year, :header_id, :product_id, :warehouse_id)
    end
end
