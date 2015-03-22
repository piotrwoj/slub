class Reservation < ActiveRecord::Base
	validates_presence_of :book_id

	belongs_to :book
end
