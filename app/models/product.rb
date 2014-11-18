class Product < ActiveRecord::Base
  set_primary_key "id"
  include UUIDHelper
  attr_accessible :code, :domain, :description, :id, :price, :units, :username, :version, :brand_id, :category_id

  validates :code, presence: true
  validates :description, presence: true
  validates :units, presence: true
  validates :price, presence: true

  belongs_to :company, :foreign_key => 'domain'
  belongs_to :brand
  belongs_to :category

  UNIT_TYPES = ["UND","MTS","HRS"]
  validates :units, inclusion: UNIT_TYPES
end
