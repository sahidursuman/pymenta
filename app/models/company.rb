class Company < ActiveRecord::Base
  set_primary_key "id"
  include UUIDHelper
  attr_accessible :address, :name
  has_many :companies, :foreign_key => 'domain'
end
