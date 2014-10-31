class DocumentLine < ActiveRecord::Base
  set_primary_key "id"
  include UUIDHelper
  attr_accessible :code, :date, :description, :document_number, :domain, :id, :in_quantity, :month, :out_quantity, :price, :total, :type, :username, :version, :year
  self.inheritance_column = nil

  belongs_to :company, :foreign_key => 'domain'
  belongs_to :document, :foreign_key => 'header_id'
  belongs_to :product
  belongs_to :warehouse
  belongs_to :stock
end
