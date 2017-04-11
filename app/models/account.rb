class Account < ApplicationRecord
  self.primary_key = 'id'
  validates :code, presence: true
  validates :name, presence: true
  validates :city, presence: true 
  
  belongs_to :company, :foreign_key => 'domain'
  
  has_many :documents
  
end
