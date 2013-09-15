class Company < ActiveRecord::Base
  set_primary_key "id"
  include UUIDHelper
  attr_accessible :address, :name
  has_many :users, :foreign_key => 'domain'
end
