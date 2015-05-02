# -*- encoding : utf-8 -*-

class Reservation < ActiveRecord::Base
	validates_presence_of :book_id

	belongs_to :book
end

# == Schema Information
#
# Table name: reservations
#
#  id         :integer          not null, primary key
#  ip         :string
#  book_id    :integer          not null
#  canceled   :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
