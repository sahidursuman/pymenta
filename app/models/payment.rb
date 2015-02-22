class Payment < ActiveRecord::Base
  set_primary_key "id"
  include UUIDHelper
  attr_accessible :amount, :date, :domain, :id, :notes, :payment_type, :username, :version, :header_id

  belongs_to :company, :foreign_key => 'domain'
  belongs_to :payments_document

  TYPES = ["CHEQUE","DEPOSITO","EFECTIVO"]
  validates :payment_type, inclusion: TYPES

  before_create :sum_payments
  before_destroy :substract_payments

  protected

  def sum_payments
    document.paid = document.paid + amount
    document.paid_left = document.total - document.paid
    if (document.paid > 0 && document.paid_left > 0) 
      document.status = "PARTIAL_PAID"
    elsif (document.paid > 0 && document.paid_left == 0) 
      document.status = "PAID"
    elsif document.paid == 0 
      document.status = "NOT_PAID"
    end		
    document.save
  end

  def substract_payments
    document.paid = document.paid - amount
    document.paid_left = document.paid_left + amount
    if (document.paid > 0 && document.paid_left > 0) 
      document.status = "PARTIAL_PAID"
    elsif (document.paid > 0 && document.paid_left == 0) 
      document.status = "PAID"
    elsif document.paid == 0 
      document.status = "NOT_PAID"
    end
    document.save
  end

end