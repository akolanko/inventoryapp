class ProductsController < ApplicationController

  def all
    @user = User.find(params[:user_id])
    @products = Product.where(user_id: params[:user_id]).page(params[:page]).per(10)
  end

  def instock
    @user = User.find(params[:user_id])
    @products = Product.where(user_id: params[:user_id], soldout: false).page(params[:page]).per(10)
  end

  def soldout
    @user = User.find(params[:user_id])
    @products = Product.where(user_id: params[:user_id], soldout: true).page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
    @category = Category.find(params[:category_id])
    @user = User.find(params[:user_id])
  end

  def new
    @product = Product.new
    @category = Category.find(params[:category_id])
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.find(params[:user_id])
    @category = Category.find(params[:category_id])
    @product = Product.new(product_params)
    @product.category_id = params[:category_id]
    @product.user_id = params[:user_id]
    if @product.save
      flash[:notice] = "#{@product.name} created successfully."
      redirect_to user_category_product_path(@user.id, @product.category.id, @product.id)
    else
      flash[:alert] = "There were some problems saving your product."
      render "new"
    end
  end

  def edit
    @product = Product.find(params[:id])
    @category = Category.find(params[:category_id])
    @user = User.find(params[:user_id])
  end

  def update
    @user = User.find(params[:user_id])
    @category = Category.find(params[:category_id])
    @product = Product.where(id: params[:id]).first
    if @product.update_attributes(product_params)
      flash[:notice] = "Product updated sucessfully."
      redirect_to user_category_product_path(@user.id, @category.id, @product.id)
    else
      flash[:alert] = "There was a problem updating the information."
      redirect_to :back
    end
  end

  def destroy
    @product = Product.where(id: params[:id]).first
    @category = Category.where(id: @product.category_id).first
    @user = User.where(id: @category.user_id).first
    if @product && @product.destroy
      flash[:notice] = "Product deleted sucessfully."
      redirect_to user_category_path(@user.id, @category.id)
    else
      flash[:alert] = "There was a problem deleting this product."
      redirect_to :back
    end
  end

private
  def product_params
    params.require(:product).permit(:name, :color, :material, :size, :measurements, :description, :price, :inventory, :soldout, :image)
  end

end
