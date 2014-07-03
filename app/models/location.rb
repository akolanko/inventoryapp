class Location < ActiveRecord::Base
	validates :location, presence: true
	validates :contact_phone, numericality: {only_integer: true}, allow_nil: true, length: {is: 10}

	belongs_to :product
end
