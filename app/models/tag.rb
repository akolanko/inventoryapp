class Tag < ActiveRecord::Base
	belongs_to :product

	validates :name, presence: true, :case_sensitive => false
end
