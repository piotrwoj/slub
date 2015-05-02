# -*- encoding : utf-8 -*-

class User < ActiveRecord::Base
	validates :login, presence: true, uniqueness: true
  has_secure_password
end

# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  login           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
