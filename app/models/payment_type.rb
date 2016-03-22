class PaymentType < ActiveRecord::Base
  set_primary_key "id"
  include UUIDHelper
  attr_accessible :code, :description, :domain, :id, :username, :version
  
  validates :code, presence: true
  validates :description, presence: true
  
  belongs_to :company, :foreign_key => 'domain'
  has_many :payments, :dependent => :restrict 
end
