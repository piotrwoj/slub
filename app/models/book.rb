# -*- encoding : utf-8 -*-

class Book < ActiveRecord::Base
	validates_uniqueness_of :title, presence: true, scope: :author

	has_many :reservations, dependent: :delete_all
	after_save :create_reservation

	attr_accessor :reserved

	def reserved?
		self.reservations.any?{|r| !r.canceled}
	end

	def my?(session)
		return false if session[:reservation_id].blank?
		return !Reservation.where(canceled: false, book_id: self.id, id: session[:reservation_id]).empty? 
	end

	def self.get_my(session)
		return nil if session[:reservation_id].blank?
		r = Reservation.where(canceled: false, id: session[:reservation_id]).first
		if r
			return r.book
		else
			return nil
		end
	end

	def self.reserved_count
		Book.joins(:reservations).where(reservations: {canceled: false}).count
	end

	def get_tr_color
		if self.reserved?
			return 'green' if self.reservations.where(canceled: false).first.updated_at > Time.zone.now - 1.day
		elsif self.reservations.any? && self.reservations.where(canceled: true).order("updated_at desc").first.updated_at > Time.zone.now - 1.day
			return 'red'
		else
			return 'inherit'
		end
	end


	private

	#manualna rezerwacja/anulowanie rezerwacji przez admina
	def create_reservation
    if !self.reserved? && self.reserved == '1'
    	self.reservations.create!
  	elsif self.reserved? && self.reserved == '0'
  		self.reservations.update_all(canceled: true)
  	end
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
#  hidden_note :text
#
