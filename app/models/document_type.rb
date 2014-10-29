class DocumentType < ActiveRecord::Base
  set_primary_key "id"
  include UUIDHelper
  attr_accessible :account_type, :description, :domain, :id, :stock, :stock_type, :username, :version
  
  validates :description, presence: true

  belongs_to :company, :foreign_key => 'domain'

  ACCOUNT_TYPES = ["Client","Provider","Warehouse"]
  validates :account_type, inclusion: ACCOUNT_TYPES

  STOCK_TYPES = ["debit","credit"]
  validates :stock_type, inclusion: STOCK_TYPES

end
