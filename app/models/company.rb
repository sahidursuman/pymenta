class Company < ActiveRecord::Base
  set_primary_key "id"
  include UUIDHelper
  attr_accessible :address, :name
  has_many :users, :foreign_key => 'domain'
  has_many :products, :foreign_key => 'domain'
  has_many :brands, :foreign_key => 'domain'
  has_many :categories, :foreign_key => 'domain'
  has_many :accounts, :foreign_key => 'domain'
end
