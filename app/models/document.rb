class Document < ActiveRecord::Base
  set_primary_key "id"
  include UUIDHelper
  attr_accessible :code, :date, :discount_percentage, :discount_total, :document_number, :domain, :due, :expire_date, :id, :month, :paid, :paid_left,
   :status, :sub_total, :tax, :tax_total, :total, :type, :username, :version, :year, :account_id, :warehouse_id, :document_type_id, :details, :control_number
  self.inheritance_column = nil

  belongs_to :company, :foreign_key => 'domain'
  belongs_to :document_type
  belongs_to :account
  belongs_to :warehouse
  belongs_to :payments_document

  has_many :document_lines, :foreign_key => 'header_id'

  before_save :default_values
  
  def default_values
      self.status ||= 'NOT_PAID'
  end

  def full_name
     "#{type} ------ #{document_number} ------- #{account.name} -------- #{date} ---------- #{sub_total}---------- #{tax_total}---------- #{total}"
   end
end
