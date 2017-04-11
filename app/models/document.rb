class Document < ApplicationRecord
  self.primary_key = 'id'  
  self.inheritance_column = nil

  belongs_to :company, :foreign_key => 'domain'
  belongs_to :document_type
  belongs_to :account
  belongs_to :warehouse
  belongs_to :payments_document

  has_many :document_lines, :foreign_key => 'header_id'

  before_validation :ensure_counter_is_not_greater_than_limit, :on => :create
  before_create :increment_counter, :default_values 
  before_save :save_type_description, :save_child_type 
  
  def default_values
      self.status ||= 'NOT_PAID'
  end

  def save_type_description
    self.type = self.document_type.description
  end

  def save_child_type
    Document.transaction do
      document_lines.each do |child|
        child.type = self.type 
        child.save
      end
    end
  end

  private
    def ensure_counter_is_not_greater_than_limit
      if self.company.counter >= self.company.limit
        errors[:base] << "Ha alcanzado el limite de su plan. Por favor actualice su plan para seguir usando la aplicacion"
      end
    end

    def increment_counter
      self.company.counter = self.company.counter + 1
      self.company.save
    end


  def full_name
     "#{type} ------ #{document_number} ------- #{account.name} -------- #{date} ---------- #{sub_total}---------- #{tax_total}---------- #{total}"
   end

end
