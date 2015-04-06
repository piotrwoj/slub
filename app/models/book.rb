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

# == Schema Information
#
# Table name: books
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  description :text
#  author      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
