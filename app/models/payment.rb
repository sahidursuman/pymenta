class Payment < ActiveRecord::Base
  set_primary_key "id"
  include UUIDHelper
  attr_accessible :amount, :date, :domain, :id, :notes, :payment_type, :username, :version

  belongs_to :company, :foreign_key => 'domain'
  belongs_to :document, :foreign_key => 'header_id'
end
