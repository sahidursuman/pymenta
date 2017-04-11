class Company < ApplicationRecord
  self.primary_key = 'id'  
  validates :name, presence: true

  PLANS = ["GRATIS","PAGO"]
  validates :plan, inclusion: PLANS
  
  has_many :users, :foreign_key => 'domain'
  has_many :products, :foreign_key => 'domain'
  has_many :brands, :foreign_key => 'domain'
  has_many :categories, :foreign_key => 'domain'
  has_many :accounts, :foreign_key => 'domain'
  has_many :document_types, :foreign_key => 'domain'
  has_many :stocks, :foreign_key => 'domain'
  has_many :documents, :foreign_key => 'domain'
  has_many :document_lines, :foreign_key => 'domain'
  has_many :payments, :foreign_key => 'domain'
  has_many :payments_documents, :foreign_key => 'domain'
  has_many :service_payments, :foreign_key => 'domain'
  has_many :payment_types, :foreign_key => 'domain'
  
  has_attached_file :logo,
      :storage => :dropbox,
      :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
      :dropbox_options => {
       path: proc{|style| "#{style}/#{id}_#{logo.original_filename}"}
      },
      styles: {
      thumb: '100x100>',
      square: '500x200>',
      medium: '300x300>'
    }, :url => '/:class/:attachment/:id/:style_:basename.:extension'

# Validate content type
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

end
