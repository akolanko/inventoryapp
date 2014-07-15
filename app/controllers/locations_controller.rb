class LocationsController < ApplicationController

  def all
    @user = User.find(params[:user_id])
    @locations = Location.where(user_id: params[:user_id]).page(params[:page]).per(10)
  end

  def search
  	@user = User.find(params[:user_id])
    @locations = Location.where(user_id: params[:user_id], location: params[:query].to_s.downcase).page(params[:page]).per(10)
  end

  def new
    @location = Location.new
    @product = Product.find(params[:product_id])
    @category = Category.find(params[:category_id])
    @user = User.find(params[:user_id])
  end

  def create
  	@user = User.find(params[:user_id])
    @category = Category.find(params[:category_id])
    @product = Product.find(params[:product_id])
    @location = Location.new(location_params)
    @location.update_attributes(location: @location.location.downcase)
    @location.product_id = @product.id
    @location.user_id = @user.id
    if @location.save
      flash[:notice] = "Location created sucessfully."
      redirect_to user_category_product_path(@user.id, @category.id, @product.id)
    else
      flash[:alert] = "There were some problems saving your location."
      render "new"
    end
  end

  def edit
    @location = Location.find(params[:id])
    @product = Product.find(params[:product_id])
    @category = Category.find(params[:category_id])
    @user = User.find(params[:user_id])
  end

  def update
  	@user = User.find(params[:user_id])
    @category = Category.find(params[:category_id])
    @product = Product.find(params[:product_id])
    @location = Location.where(id: params[:id]).first
    @location.update_attributes(location_params)
    @location.update_attributes(location: @location.location.downcase)
    if @location.save
      flash[:notice] = "Location updated sucessfully."
      redirect_to user_category_product_path(@user.id, @category.id, @product.id)
    else
      flash[:alert] = "There was a problem updating the information."
      redirect_to :back
    end
  end

  def destroy
    @location = Location.where(id: params[:id]).first
    if @location && @location.destroy
      flash[:notice] = "Location deleted sucessfully."
      redirect_to user_category_product_path(@location.user_id, @location.product.category.id, @location.product.id)
    else
      flash[:alert] = "There was a problem deleting this location."
      redirect_to :back
    end
  end

private
  def location_params
    params.require(:location).permit(:online, :location, :left_date, :return_date, :contact_name, :contact_email, :contact_phone)
  end

end
