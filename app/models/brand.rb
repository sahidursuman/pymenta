class Brand < ActiveRecord::Base
  set_primary_key "id"
  include UUIDHelper
  attr_accessible :code, :description, :domain, :id, :username, :version
  belongs_to :company, :foreign_key => 'domain'
  belongs_to :brand
end
