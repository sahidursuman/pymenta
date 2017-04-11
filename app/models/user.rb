class User < ApplicationRecord
  self.primary_key = 'id'   
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :company, :foreign_key => 'domain'       

end
