class DocumentType < ActiveRecord::Base
  set_primary_key "id"
  include UUIDHelper
  attr_accessible :account_type, :description, :domain, :id, :stock, :stock_type, :username, :version
  
  validates :code, presence: true
  validates :description, presence: true

  belongs_to :company, :foreign_key => 'domain'
end
