class CategoriesController < ApplicationController
  def index
  	@user = User.find(params[:user_id])
  	@categories = Category.where(user_id: @user.id).all
  	@category = Category.new
  end

  def show
  	@category = Category.find(params[:id])
  	@user = User.find(params[:user_id])
  	@products = @category.products.page(params[:page]).per(10)
  end

  def instock
    @user = User.find(params[:user_id])
    @category = Category.find(params[:category_id])
    @products = Product.where(user_id: params[:user_id], category_id: params[:category_id], soldout: false).page(params[:page]).per(10)
  end

  def soldout
    @user = User.find(params[:user_id])
    @category = Category.find(params[:category_id])
    @products = Product.where(user_id: params[:user_id], category_id: params[:category_id], soldout: true).page(params[:page]).per(10)
  end

  def new
  	@category = Category.new
  	@user = User.find(params[:user_id])
  end

  def create
  	@user = User.find(params[:user_id])
  	@category = Category.new(category_params)
  	@category.user_id = params[:user_id]
  	if @category.save
  		flash[:notice] = "#{@category.name} category created successfully."
  		redirect_to user_categories_path(@user.id)
  	else
  		flash[:alert] = "There was a problem saving your category."
  		redirect_to :back
  	end
  end

  def destroy
  	@category = Category.where(id: params[:id]).first
  	@user = User.where(id: @category.user_id).first
  	if @category && @category.destroy
  		flash[:notice] = "#{@category.name} deleted successfully."
  		redirect_to user_categories_path(@user.id)
  	else
  		flash[:alert] = "There was a problem deleting your category."
  		redirect_to :back
  	end
  end

private
	def category_params
		params.require(:category).permit(:name)
	end

end
