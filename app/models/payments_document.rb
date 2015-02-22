class PaymentsDocument < ActiveRecord::Base
  set_primary_key "id"
  include UUIDHelper
  attr_accessible :date, :domain, :id, :month, :number, :paid, :paid_left, :total, :type, :username, :version, :year
  
  belongs_to :document_type
  belongs_to :account
  
  has_many :payments
  has_many :documents
end
