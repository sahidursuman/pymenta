class PaymentsDocumentsController < ApplicationController
  # GET /payments_documents
  # GET /payments_documents.json
  def index
    @payments_documents = current_user.company.payments_documents.paginate(:page => params[:page], :per_page => 10, :order => 'created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @payments_documents }
    end
  end

  # GET /payments_documents/1
  # GET /payments_documents/1.json
  def show
    @payments_document = PaymentsDocument.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @payments_document }
    end
  end

  # GET /payments_documents/new
  # GET /payments_documents/new.json
  def new
    @payments_document = PaymentsDocument.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @payments_document }
    end
  end

  # GET /payments_documents/1/edit
  def edit
    @payments_document = PaymentsDocument.find(params[:id])
  end

  # POST /payments_documents
  # POST /payments_documents.json
  def create
    params[:payments_document][:version] = ENV["VERSION"]
    params[:payments_document][:domain] = current_user.domain
    params[:payments_document][:username] = current_user.username
    @payments_document = PaymentsDocument.new(params[:payments_document])

    respond_to do |format|
      if @payments_document.save
        format.html { redirect_to @payments_document, notice: 'Payments document was successfully created.' }
        format.json { render json: @payments_document, status: :created, location: @payments_document }
      else
        format.html { render action: "new" }
        format.json { render json: @payments_document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /payments_documents/1
  # PUT /payments_documents/1.json
  def update
    params[:payments_document][:version] = ENV["VERSION"]
    params[:payments_document[:username] = current_user.username
    @payments_document = PaymentsDocument.find(params[:id])

    respond_to do |format|
      if @payments_document.update_attributes(params[:payments_document])
        format.html { redirect_to @payments_document, notice: 'Payments document was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @payments_document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments_documents/1
  # DELETE /payments_documents/1.json
  def destroy
    @payments_document = PaymentsDocument.find(params[:id])
    @payments_document.destroy

    respond_to do |format|
      format.html { redirect_to payments_documents_url }
      format.json { head :no_content }
    end
  end
end
