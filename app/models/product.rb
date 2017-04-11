class Product < ApplicationRecord
  self.primary_key = 'id'  
  validates :code, presence: true
  validates :description, presence: true
  validates :units, presence: true
  validates :price, presence: true

  belongs_to :company, :foreign_key => 'domain'
  belongs_to :brand
  belongs_to :category

  has_many :stocks
  has_many :document_lines
  
  UNIT_TYPES = ["UND","MTS","HRS"]
  validates :units, inclusion: UNIT_TYPES

end
