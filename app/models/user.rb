class User < ActiveRecord::Base
  has_many :recipes, dependent: :destroy
  has_secure_password
end