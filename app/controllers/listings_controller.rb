class ListingsController < ApplicationController
  
  def all
  	@user = User.find(params[:user_id])
    @listings = Listing.where(user_id: params[:user_id]).page(params[:page]).per(10)
  end

  def search
  	@user = User.find(params[:user_id])
    @listings = Listing.where(user_id: params[:user_id], website: params[:query].to_s.downcase).page(params[:page]).per(10)
  end

  def new
  	@listing = Listing.new
    @product = Product.find(params[:product_id])
    @category = Category.find(params[:category_id])
    @user = User.find(params[:user_id])
  end

  def create
  	@user = User.find(params[:user_id])
  	@category = Category.find(params[:category_id])
    @product = Product.find(params[:product_id])
    @listing = Listing.new(listing_params)
    @listing.update_attributes(website: @listing.website.downcase)
    @listing.product_id = @product.id
    @listing.user_id = @user.id
    if @listing.save
      flash[:notice] = "Listing created sucessfully."
      redirect_to user_category_product_path(@user.id, @category.id, @product.id)
    else
      flash[:alert] = "There were some problems saving your listing."
      render "new"
    end
  end

  def edit
  	@listing = Listing.find(params[:id])
    @product = Product.find(params[:product_id])
    @category = Category.find(params[:category_id])
    @user = User.find(params[:user_id])
  end

  def update
  	@user = User.find(params[:user_id])
  	@category = Category.find(params[:category_id])
    @product = Product.find(params[:product_id])
    @listing = Listing.where(id: params[:id]).first
    @listing.update_attributes(listing_params)
    @listing.update_attributes(website: @listing.website.downcase)
    if @listing.save
      flash[:notice] = "Listing updated sucessfully."
      redirect_to user_category_product_path(@user.id, @category.id, @product.id)
    else
      flash[:alert] = "There was a problem updating the information."
      redirect_to :back
    end
  end

  def destroy
  	@listing = Listing.where(id: params[:id]).first
    if @listing && @listing.destroy
      flash[:notice] = "Listing deleted sucessfully."
      redirect_to user_category_product_path(@listing.user_id, @listing.product.category.id, @listing.product.id)
    else
      flash[:alert] = "There was a problem deleting this listing."
      redirect_to :back
    end
  end

private
	def listing_params
		params.require(:listing).permit(:website, :posted_date, :end_date)
	end
end
