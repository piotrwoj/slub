class Book < ActiveRecord::Base
	validates_uniqueness_of :title, presence: true, scope: :author
end
