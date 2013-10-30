class Product < ActiveRecord::Base
  set_primary_key "id"
  include UUIDHelper
  attr_accessible :code, :description, :id, :price, :units, :username, :version
  belongs_to :company, :foreign_key => 'domain'
end
