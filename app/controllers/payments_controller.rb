class PaymentsController < ApplicationController
  # GET /payments
  # GET /payments.json
  before_action :authenticate_user!
  def index
    @payments = current_user.company.payments.paginate(:page => params[:page], :per_page => 10).order('created_at ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @payments }
    end
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
    @payment = Payment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @payment }
    end
  end

  # GET /payments/new
  # GET /payments/new.json
  def new
    @payment = Payment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @payment }
    end
  end

  # GET /payments/1/edit
  def edit
    @payment = Payment.find(params[:id])
  end

  # POST /payments
  # POST /payments.json
  def create
    params[:payment][:version] = ENV["VERSION"]
    params[:payment][:domain] = current_user.domain
    params[:payment][:username] = current_user.username
    @payment = Payment.new(payment_params)

    respond_to do |format|
      if @payment.save
        format.html { redirect_to @payment, notice: 'Payment was successfully created.' }
        format.json { render json: @payment, status: :created, location: @payment }
      else
        format.html { render action: "new" }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /payments/1
  # PUT /payments/1.json
  def update
    params[:payment][:version] = ENV["VERSION"]
    params[:payment][:username] = current_user.username
    @payment = Payment.find(params[:id])

    respond_to do |format|
      if @payment.update_attributes(payment_params)
        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment = Payment.find(params[:id])
    @payments_document = PaymentsDocument.find(@payment.payments_document.id)
    @payment.destroy

    respond_to do |format|
      format.html { redirect_to @payments_document, notice: 'Payment was successfully deleted.'  }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:amount, :date, :domain, :id, :notes, :payment_type_id, :username, :version, :payments_document_id)
    end
end
