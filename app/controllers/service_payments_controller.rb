class ServicePaymentsController < ApplicationController
  before_action :authenticate_user!
  def index
    @service_payments = current_user.company.service_payments.all( :limit => 10, :order => "id DESC" )
  end

  def subscribe_month
    @service_payment = ServicePayment.new
    @service_payment.amount = 22
    @service_payment.description = t("helpers.links.subscribe_month") 
    @service_payment.period = 'month'  
    @service_payment.method = 'Paypal'      
    subscribe(@service_payment)
  end  
  
  def subscribe_year
    @service_payment = ServicePayment.new
    @service_payment.amount = 220
    @service_payment.description = t("helpers.links.subscribe_year") 
    @service_payment.period = 'year'  
    @service_payment.method = 'Paypal'  
    subscribe(@service_payment)
  end


  def subscribe(service_payment)
    service_payment.domain = current_user.domain
    service_payment.return_url = service_payment_execute_url(":service_payment_id")
    service_payment.cancel_url = service_payment_cancel_url(":service_payment_id")
    if service_payment.save
      if service_payment.approve_url
        redirect_to service_payment.approve_url
      else
        redirect_to company_path(:id => current_user.company.id), :notice => t('helpers.labels.service_payments')+" "+t('helpers.labels.approved')
      end
    else
      render company_path(:id => current_user.company.id), :alert  => service_payment.errors.to_a.join(", ")
    end
  end

  def execute
    service_payment = current_user.company.service_payments.find(params[:service_payment_id])
    if service_payment.execute(params["PayerID"])
       if service_payment.period == "month"
         @company = current_user.company
         @company.plan = "PAGO"
         @company.initial_cycle = Time.new
         @company.final_cycle = Time.now.months_since(1)
         @company.counter = 0
         @company.limit = 1000000
         @company.save
       elsif service_payment.period == "year"
         @company = current_user.company
         @company.plan = "PAGO"
         @company.initial_cycle = Time.new
         @company.final_cycle = Time.now.years_since(1)
         @company.counter = 0
         @company.limit = 1000000
         @company.save
       end           
      redirect_to company_path(:id => current_user.company.id), :notice => t('helpers.labels.service_payments')+" "+t('helpers.labels.approved')
    else
      redirect_to company_path(:id => current_user.company.id), :alert => service_payment.payment.error.inspect
    end
  end

  def cancel
    service_payment = current_user.company.service_payments.find(params[:service_payment_id])
    unless service_payment.state == "approved"
      service_payment.state = "cancelled"
      service_payment.method = "Paypal"
      service_payment.save
    end
    redirect_to company_path(:id => current_user.company.id), :notice => t('helpers.labels.service_payments')+" "+t('helpers.labels.cancelled')
  end

  def show
    @service_payment = current_user.company.service_payments.find(params[:id])
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service_payment
      @service_payment = ServicePayments.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_payment_params
      params.require(:service_payment).permit(:amount, :description, :payment_id, :state, :period, :method, :domain)
    end

end

