class User < ActiveRecord::Base
  has_many :tasks, through: :lists 
  has_many :lists

  has_secure_password
end