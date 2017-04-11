class ServicePayment < ApplicationRecord
  self.primary_key = 'id'  
  belongs_to :company, :foreign_key => 'domain'

  validates_presence_of :amount, :description

  after_create :create_payment

  attr_accessor :return_url, :cancel_url

  def payment
   @payment ||= payment_id && PaypalPayment.find(payment_id)
  end

  def create_payment
   @payment = PaypalPayment.new( :service_payment => self )
   if @payment.create
     self.payment_id = @payment.id
     self.state      = @payment.state
     save
   else
     errors.add :payment_method, @payment.error["message"] if @payment.error
     raise ActiveRecord::Rollback, "Can't place the order"
   end
  end

  def execute(payer_id)
   if payment.present? and payment.execute(:payer_id => payer_id)
     self.state = payment.state
     save
   else
     errors.add :description, payment.error.inspect
     false
   end
  end

  def approve_url
   payment.links.find{|link| link.method == "REDIRECT" }.try(:href)
  end

end

