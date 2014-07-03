class Listing < ActiveRecord::Base
	validates :website, presence: true

	belongs_to :product
end
