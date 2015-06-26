class PaymentsDocumentsController < ApplicationController
  # GET /payments_documents
  # GET /payments_documents.json
  before_filter :authenticate_user!
  def search
   @start_at = params[:start_at].blank? ? DateTime.parse("01/01/1901") : DateTime.parse(params[:start_at])
   @end_at = params[:end_at].blank? ? DateTime.parse("01/01/2901") : DateTime.parse(params[:end_at])
   @status = params[:status]
   if @status.blank?
     @payments_documents = PaymentsDocument.where("domain = ? AND name like ? AND date > ? AND date < ? ", current_user.domain,"%#{params[:name]}%","#{@start_at}","#{@end_at}").paginate(:page => params[:page], :per_page => 10, :order => 'name ASC')
   else      
     @payments_documents = PaymentsDocument.where("domain = ? AND name like ? AND date > ? AND date < ? AND status = ? ", current_user.domain,"%#{params[:name]}%","#{@start_at}","#{@end_at}","#{@status}").paginate(:page => params[:page], :per_page => 10, :order => 'name ASC')
   end
    render :index
  end
    
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
    params[:payments_document][:username] = current_user.username
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

  def create_payments_document_account

    @document_type_id = params[:payments_document] != nil ? params[:payments_document][:document_type_id] : params[:document_type_id] 
    document_type = DocumentType.find(@document_type_id)
    account_type = document_type.account_type
    puts "esta es " + account_type
    if(account_type=='Client')
        account = Client.find(params[:autocomplete_client])
    elsif(account_type=='Provider')
         account = Provider.find(params[:autocomplete_provider])     
    elsif(account_type=='Warehouse')
         account = Warehouse.find(params[:autocomplete_warehouse])           
    end

    @payments_document = PaymentsDocument.new
    @payments_document.version = ENV["VERSION"]
    @payments_document.domain = current_user.domain
    @payments_document.username = current_user.username
    @payments_document.account_id = account.id
    @payments_document.document_type_id = document_type.id
    @payments_document.type = document_type.description
    @payments_document.name = account.name
    @payments_document.total = 0
    @payments_document.paid = 0
    @payments_document.paid_left = 0
    @payments_document.month  = Time.new.month+1
    @payments_document.year  = Time.new.year+1900
    @payments_document.status  = "NOT_PAID"

    @payments_document.percentage = params[:payments_document] != nil ? params[:payments_document][:percentage] : 0.75
    @payments_document.number = params[:payments_document] != nil ? params[:payments_document][:number] : ''
    @payments_document.date = params[:payments_document] != nil ? Time.parse("#{params[:payments_document]['date(3i)']}-#{params[:payments_document]['date(2i)']}-#{params[:payments_document]['date(1i)']}") : Time.now


    respond_to do |format|
      if @payments_document.save
        format.html { redirect_to @payments_document, notice: 'Payment Document was successfully created.' }
        format.json { render json: @payments_document, status: :created, location: @document }
      else
        format.html { render action: "new" }
        format.json { render json: @payments_document.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_payments_document_id

     @payments_document = PaymentsDocument.find(params[:document][:payment_id])   

     @document = Document.find(params[:document][:payments_document_id] )
     @document.payments_document = @payments_document
  
     @payments_document.total = @payments_document.total + @document.total
     @payments_document.paid_left = (@payments_document.paid_left.nil? ? 0 : @payments_document.paid_left) + (@document.total.round(2)) 

     respond_to do |format|
       if @document.save && @payments_document.save
         format.html { redirect_to @payments_document, notice: 'Add Document was successfully created.' }
         format.json { render json: @payments_document, status: :created, location: @document }
       else
         format.html { render action: "new" }
         format.json { render json: @payments_document.errors, status: :unprocessable_entity }
       end
     end
   end

   def remove_payments_document_id

      @payments_document = PaymentsDocument.find(params[:id])

      @document = Document.find(params[:payments_document_id])
      @document.payments_document_id = nil

      @payments_document.total = @payments_document.total - @document.total 
      @payments_document.paid_left = (@payments_document.paid_left.nil? ? 0 : @payments_document.paid_left)- (@document.total.round(2))

      respond_to do |format|
        if @document.save  && @payments_document.save
          format.html { redirect_to @payments_document, notice: 'Remove Document was successfully created.' }
          format.json { render json: @payments_document, status: :created, location: @document }
        else
          format.html { render action: "new" }
          format.json { render json: @payments_document.errors, status: :unprocessable_entity }
        end
      end
    end

    def create_payment_line
      puts 'hola'
      puts params[:payment_type]
      puts params[:date]
      puts 'hola'
      payments_document = PaymentsDocument.find(params[:header_id])
      amount = params[:amount].to_f
      date = Date.parse("#{params[:date]['day']}-#{params[:date]['month']}-#{params[:date]['year']}") if params[:date]
      payment_line = Payment.new(domain: current_user.domain, username: current_user.username,      
  	payments_document_id: payments_document.id, payment_type: params[:payment_type], date: date,  amount: amount,
  	notes: params[:notes])
      if payment_line.save!
        flash[:notice]='Your payment was created'
      else
        flash[:notice]='Please verify your data'
      end

      respond_to do |format|
        format.html{ redirect_to payments_document }
      end
    end

end
