class User < ActiveRecord::Base
	validates :login, presence: true, uniqueness: true
  has_secure_password
end
