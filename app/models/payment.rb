class Payment < ActiveRecord::Base
  set_primary_key "id"
  include UUIDHelper
  attr_accessible :amount, :date, :domain, :id, :notes, :payment_type, :username, :version, :payments_document_id

  belongs_to :company, :foreign_key => 'domain'
  belongs_to :payments_document

  TYPES = ["CHEQUE","DEPOSITO","EFECTIVO"]
  validates :payment_type, inclusion: TYPES

  before_create :sum_payments
  before_destroy :substract_payments

  protected

  def sum_payments
    payments_document.paid = payments_document.paid + amount
    payments_document.paid_left = payments_document.total - payments_document.paid
    if (payments_document.paid > 0 && payments_document.paid_left > 0) 
      payments_document.status = "PARTIAL_PAID"
    elsif (payments_document.paid > 0 && payments_document.paid_left == 0) 
      payments_document.status = "PAID"
    elsif payments_document.paid == 0 
      payments_document.status = "NOT_PAID"
    end		
    payments_document.save
  end

  def substract_payments
    payments_document.paid = payments_document.paid - amount
    payments_document.paid_left = payments_document.paid_left + amount
    if (payments_document.paid > 0 && payments_document.paid_left > 0) 
      payments_document.status = "PARTIAL_PAID"
    elsif (payments_document.paid > 0 && payments_document.paid_left == 0) 
      payments_document.status = "PAID"
    elsif payments_document.paid == 0 
      payments_document.status = "NOT_PAID"
    end
    payments_document.save
  end

end