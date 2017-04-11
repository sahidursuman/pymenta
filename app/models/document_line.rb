class DocumentLine < ApplicationRecord
  self.primary_key = 'id'  
  self.inheritance_column = nil

  belongs_to :company, :foreign_key => 'domain'
  belongs_to :document, :foreign_key => 'header_id'
  belongs_to :product
  belongs_to :warehouse
  belongs_to :stock

  before_create :create_functions
  before_destroy :destroy_functions

  protected

  def create_functions
    sum_totals
    create_stock
  end
  
  def destroy_functions
    substract_totals
    destroy_stock
  end  

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
  
  def create_stock 
    @stock = Stock.find_by_product_id_and_warehouse_id_and_domain(product_id, warehouse_id, domain)
    quantity = in_quantity + out_quantity
    puts "Create mode - quantity = " + quantity.to_s + " stock = " + document.document_type.stock.to_s + " stock type = " + document.document_type.stock_type
    if @stock
      if document.document_type.stock
        if document.document_type.stock_type == 'credit'
          @stock.in_quantity = @stock.in_quantity + quantity
        elsif document.document_type.stock_type == 'debit'
          @stock.out_quantity = @stock.out_quantity + quantity
        end
        @stock.save
      end   
    else
      if document.document_type.stock
        @stock = Stock.new
        @stock.domain = domain
        @stock.username = username
        @stock.product_id = product_id
        @stock.warehouse_id = warehouse_id
        if document.document_type.stock_type == 'credit'
          @stock.in_quantity = quantity
          @stock.out_quantity = 0
        elsif document.document_type.stock_type == 'debit'
          @stock.out_quantity = quantity
          @stock.in_quantity = 0
        end
        @stock.save
      end  
    end
  end
  
  def destroy_stock
    @stock = Stock.find_by_product_id_and_warehouse_id_and_domain(product_id, warehouse_id, domain)
    quantity = in_quantity + out_quantity
    puts "Destroy mode - quantity = " + quantity.to_s + " stock = " + document.document_type.stock.to_s + " stock type = " + document.document_type.stock_type
    if @stock
      if document.document_type.stock
        if document.document_type.stock_type == 'credit'
          @stock.in_quantity = @stock.in_quantity - quantity
        elsif document.document_type.stock && document.document_type.stock_type == 'debit'
          @stock.out_quantity = @stock.out_quantity - quantity
        end
        @stock.save
      end
    else
      if document.document_type.stock
        @stock = Stock.new
        @stock.domain = domain
        @stock.username = username
        @stock.product_id = product_id
        @stock.warehouse_id = warehouse_id
        if document.document_type.stock_type == 'credit'
          @stock.in_quantity = -quantity
          @stock.out_quantity = 0
        elsif document.document_type.stock_type == 'debit'
          @stock.out_quantity = -quantity
          @stock.in_quantity = 0
        end
        @stock.save
      end  
    end   
  end
      
end
