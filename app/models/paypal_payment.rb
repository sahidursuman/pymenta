class PaypalPayment < PayPal::SDK::REST::Payment
  include ActiveModel::Validations

  def create
    return false if invalid?
    super
  end

  def error=(error)
    error["details"].each do |detail|
      errors.add detail["field"], detail["issue"]
    end if error and error["details"]
    super
  end


  def service_payment=(service_payment)
    self.intent = "sale"
    self.payer.payment_method = "paypal"
    self.transactions = {
      :amount => {
        :total => service_payment.amount,
        :currency => "USD" },
      :item_list => {
        :items => { :name => service_payment.description, :sku => "SUBSC", :price => service_payment.amount, :currency => "USD", :quantity => 1 }
      },
      :description => service_payment.description
     }
     self.redirect_urls = {
       :return_url => service_payment.return_url.sub(/:service_payment_id/, service_payment.id.to_s),
       :cancel_url => service_payment.cancel_url.sub(/:service_payment_id/, service_payment.id.to_s)
     }
  end

end
