class DocumentLine < ActiveRecord::Base
  set_primary_key "id"
  include UUIDHelper
  attr_accessible :code, :date, :description, :document_number, :domain, :id, :in_quantity, :month, :out_quantity, :price,
   :total, :type, :username, :version, :year, :header_id, :product_id, :warehouse_id
  self.inheritance_column = nil

  belongs_to :company, :foreign_key => 'domain'
  belongs_to :document, :foreign_key => 'header_id'
  belongs_to :product
  belongs_to :warehouse
  belongs_to :stock

  before_create :sum_totals
  before_destroy :substract_totals

  protected

  def sum_totals
    total = (out_quantity+in_quantity)*price
    description = product.description
    code = product.code
    document.sub_total = document.sub_total + total
    document.tax_total = document.tax_total + (total*document.tax/100)
    document.total = document.sub_total + document.tax_total
    document.paid_left = document.paid_left + total + (total*document.tax/100)
    document.save
  end

  def substract_totals
    document.sub_total = document.sub_total - total
    document.tax_total = document.tax_total - (total*document.tax/100)
    document.total = document.sub_total + document.tax_total
    document.paid_left = document.paid_left - total - (total*document.tax/100)
    document.save
  end
end
