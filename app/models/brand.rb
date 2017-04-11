class Brand < ApplicationRecord
  self.primary_key = 'id'
  validates :code, presence: true
  validates :description, presence: true
  
  belongs_to :company, :foreign_key => 'domain'
  has_many :products#, :dependent => :restrict 
  
end
