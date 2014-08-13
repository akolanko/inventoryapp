class Product < ActiveRecord::Base
	belongs_to :category
	has_many :locations, dependent: :destroy
	has_many :listings, dependent: :destroy
	has_many :sales, dependent: :destroy
	has_many :tags, dependent: :destroy

	validates :name, presence: true
	validates :color, presence: true
	validates :material, presence: true
	validates :price, numericality: {only_float: true}, allow_nil: true
	validates :inventory, presence: true, numericality: {only_integer: true}

	has_attached_file :image, :styles => {:medium => "400x400"}, :default_url => 'missing_:style.jpg', :storage => :s3, :s3_credentials => Proc.new{|a| a.instance.s3_credentials }
	def s3_credentials
		{:bucket => ENV['PRODUCTS_BUCKET'], :access_key_id => ENV['AWS_KEY'], :secret_access_key => ENV['AWS_SECRET']}
	end
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
	validates :image, dimensions: { width: 800, height: 800 }
end
