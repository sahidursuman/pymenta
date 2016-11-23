class Account < ActiveRecord::Base
  set_primary_key "id"
  include UUIDHelper
  attr_accessible :address, :balance, :balance_b, :city, :code, :contact, :country, :debit_credit, :domain, :email, :fax, :id, :id_number1, :id_number2, :name, :observations, :state, :telephone, :type, :username, :version, :web, :zip_code

  validates :code, presence: true
  validates :name, presence: true
  #validates :city, presence: true 
  
  belongs_to :company, :foreign_key => 'domain'
  
  has_many :documents
end
