class Document < ActiveRecord::Base
  set_primary_key "id"
  include UUIDHelper
  attr_accessible :address, :city, :code, :country, :date, :discount_percentage, :discount_total, :document_number, :domain, :due, :email, :expire_date, :fax, :id, :id_number1, :id_number2, :month, :name,
   :observations, :paid, :paid_left, :state, :status, :sub_total, :tax, :tax_total, :telephone, :total, :type, :username, :version, :web, :year, :zip_code, :account_id, :warehouse_id, :document_type_id
  self.inheritance_column = nil

  belongs_to :company, :foreign_key => 'domain'
  belongs_to :document_type
  belongs_to :account
  belongs_to :warehouse
  belongs_to :payments_document

  has_many :document_lines, :foreign_key => 'header_id'

  def full_name
     "#{type} -------- #{document_number} --------- #{name} ---------- #{date} ------------ #{total}"
   end
end
