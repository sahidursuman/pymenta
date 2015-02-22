class PaymentsDocument < ActiveRecord::Base
  attr_accessible :date, :domain, :id, :month, :number, :paid, :paid_left, :total, :type, :username, :version, :year
end
