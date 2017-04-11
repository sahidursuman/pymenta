class Stock < ApplicationRecord
  self.primary_key = 'id'  
  belongs_to :company, :foreign_key => 'domain'
  belongs_to :product
  belongs_to :warehouse
  
  before_save do
    self.stock = in_quantity - out_quantity 
  end

end
