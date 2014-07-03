class Sale < ActiveRecord::Base
	validates :price, presence: true, numericality: {only_float: true}
	validates :shipping_cost, numericality: {only_float: true}, allow_nil: true
	validates :shipping_paid, numericality: {only_float: true}, allow_nil: true
	validates :tax, numericality: {only_float: true}, allow_nil: true
	validates :through, presence: true
	
	belongs_to :product
end
