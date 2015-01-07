class DocumentsController < ApplicationController
  # GET /documents
  # GET /documents.json
  def index
    @documents = current_user.company.documents.paginate(:page => params[:page], :per_page => 10, :order => 'created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents }
    end
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    @document = Document.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @document }
    end
  end

  # GET /documents/new
  # GET /documents/new.json
  def new
    @document = Document.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @document }
    end
  end

  # GET /documents/1/edit
  def edit
    @document = Document.find(params[:id])
  end

  # POST /documents
  # POST /documents.json
  def create
    params[:document][:code] = ''
    params[:document][:date] = Time.new
    params[:document][:discount_percentage] = 0
    params[:document][:discount_total] = 0
    params[:document][:document_number] = 0
    params[:document][:expire_date] = Date.new
    params[:document][:month] = Date.new.month
    params[:document][:year] = Date.new.year
    params[:document][:name] = ''   
    params[:document][:sub_total] = 0
    params[:document][:total] = 0
    params[:document][:tax_total] = 0
    params[:document][:version] = ENV["VERSION"]
    params[:document][:domain] = current_user.domain
    params[:document][:username] = current_user.username
    @document = Document.new(params[:document])

    respond_to do |format|
        format.html { render action: "new" }
    end
  end

  # PUT /documents/1
  # PUT /documents/1.json
  def update
    params[:document][:version] = ENV["VERSION"]
    params[:document][:username] = current_user.username
    @document = Document.find(params[:id])

    respond_to do |format|
      if @document.update_attributes(params[:document])
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document = Document.find(params[:id])
    @document.destroy

    respond_to do |format|
      format.html { redirect_to documents_url }
      format.json { head :no_content }
    end
  end

  def is_document_not_paid
    @document = Document.find(params[:id])
    @document.status == "NOT_PAID"
  end
    
  def remove_document_line
    @document_line = DocumentLine.find(params[:id])
    @document_line.destroy

    respond_to do |format|
        format.html { redirect_to @document_line.document, notice: 'Document was successfully updating.' }
        format.json { render json: @document_line.document, status: :created, location: @document }
        format.js
    end
  end

  def create_document_line
    product = Product.find(params[:autocomplete])
    document = Document.find(params[:header_id])
    quantity = params[:quantity].to_f
    price = params[:price].to_f
    total = quantity*price
    document_line = DocumentLine.new(domain: current_user.domain, username: current_user.username,
      code: product.code, date: DateTime.now, description: product.description, document_number: document.document_number,
	header_id: document.id, product_id: product.id, warehouse_id: document.warehouse.id, 
	in_quantity:0, out_quantity: quantity,price: price, total: total, type: document.type, month: DateTime.now.month, year: DateTime.now.year)
    if document_line.save!
      flash[:notice]='Your line was created'
    else
      flash[:notice]='Please verify your data'
    end

    respond_to do |format|
      format.html{ redirect_to document }
    end
  end  

  def create_payment_line
    puts 'hola'
    puts params[:payment_type]
    puts params[:date]
    puts 'hola'
    document = Document.find(params[:header_id])
    amount = params[:amount].to_f
    #date = DateTime.new(params[:date])
    payment_line = Payment.new(domain: current_user.domain, username: current_user.username,      
	header_id: document.id, payment_type: params[:payment_type], date: DateTime.now,  amount: amount,
	notes: params[:notes])
    if payment_line.save!
      flash[:notice]='Your payment was created'
    else
      flash[:notice]='Please verify your data'
    end

    respond_to do |format|
      format.html{ redirect_to document }
    end
  end          

  def create_document_account

    params[:document][:version] = ENV["VERSION"]
    params[:document][:domain] = current_user.domain
    params[:document][:username] = current_user.username

    account_type = DocumentType.find(params[:document][:document_type_id]).account_type
    puts "esta es " + account_type
    if(account_type=='Client')
        account = Client.find(params[:autocomplete_client])
    elsif(account_type=='Provider')
         account = Provider.find(params[:autocomplete_provider])     
    elsif(account_type=='Warehouse')
         account = Warehouse.find(params[:autocomplete_warehouse])           
    end

    params[:document][:account_id] = account.id
    params[:document][:name] = account.name
    params[:document][:expire_date] = Time.new
    params[:document][:id_number1] = account.id_number1
    params[:document][:id_number2] = account.id_number2
    params[:document][:address] = account.address
    params[:document][:city] = account.city
    params[:document][:state] = account.state
    params[:document][:country] = account.country
    params[:document][:zip_code] = account.zip_code
    params[:document][:telephone] = account.telephone
    params[:document][:email] = account.email         
    params[:document][:web] = account.web 
    params[:document][:code] = account.code
    params[:document][:discount_percentage] = 0
    params[:document][:discount_total] = 0
    params[:document][:sub_total] = 0
    params[:document][:total] = 0
    params[:document][:tax_total] = 0
    params[:document][:paid] = 0
    params[:document][:paid_left] = 0    
    params[:document][:month] = Time.new.month+1
    params[:document][:year] = Time.new.year+1900
    params[:document][:status] = "NOT_PAID"
      
    @document = Document.new(params[:document])

    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: 'Document was successfully created.' }
        format.json { render json: @document, status: :created, location: @document }
      else
        format.html { render action: "new" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

end
