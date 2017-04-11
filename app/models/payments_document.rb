class PaymentsDocument < ApplicationRecord
  self.primary_key = 'id'  
  self.inheritance_column = nil

  belongs_to :company, :foreign_key => 'domain'        
  belongs_to :document_type
  belongs_to :account
  
  has_many :payments
  has_many :documents

  before_create :default_values
  
  def default_values
      self.status ||= 'NOT_PAID'
  end

end
