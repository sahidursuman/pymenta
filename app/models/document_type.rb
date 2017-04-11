class DocumentType < ApplicationRecord
  self.primary_key = 'id'  
  validates :description, presence: true

  belongs_to :company, :foreign_key => 'domain'

  ACCOUNT_TYPES = ["Client","Provider","Warehouse"]
  validates :account_type, inclusion: ACCOUNT_TYPES

  STOCK_TYPES = ["debit","credit"]
  validates :stock_type, inclusion: STOCK_TYPES

end
