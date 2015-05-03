# -*- encoding : utf-8 -*-

class Settings < ActiveRecord::Base
	validates_uniqueness_of :name, presence: true

	private

	def self.set_value(name, value)
		if record = self.where(name: name).first
			record.update(value: value)
		else
			self.create!(name: name, value: value)
		end
		value
	end

	def self.read_value(name)
		if record = self.where(name: name).first
			record.value
		else
			nil
		end
	end

	def self.method_missing(method, *args, &block)
		method = method.to_s
		if method.ends_with?('=')
			self.set_value(method.chop, args.first)
		else
			self.read_value(method)
		end
	end

end

# == Schema Information
#
# Table name: settings
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  value      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
