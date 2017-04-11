class PaymentType < ApplicationRecord
  self.primary_key = 'id'  
  validates :code, presence: true
  validates :description, presence: true
  
  belongs_to :company, :foreign_key => 'domain'
  has_many :payments, :dependent => :restrict_with_error

end
