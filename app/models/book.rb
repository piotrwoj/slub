class Book < ActiveRecord::Base
	validates_uniqueness_of :title, presence: true, scope: :author

	has_many :reservations, dependent: :delete_all

	def reserved?
		self.reservations.any?{|r| !r.canceled}
	end

	def my?(session)
		return false if session[:reservation_ids].blank?
		return !Reservation.where(canceled: false, book_id: self.id, id: session[:reservation_ids]).blank? 
	end
end
