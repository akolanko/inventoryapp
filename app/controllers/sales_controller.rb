class SalesController < ApplicationController
  def index
    @product = Product.find(params[:product_id])
    @category = Category.find(params[:category_id])
    @user = User.find(params[:user_id])
    @sale = Sale.new
    @sales = Sale.where(user_id: params[:user_id], product_id: params[:product_id]).page(params[:page]).per(10)
  end

  def all
  	@user = User.find(params[:user_id])
    @sales = Sale.where(user_id: params[:user_id]).page(params[:page]).per(10)
  end

  def search
    @user = User.find(params[:user_id])
    @sales = Sale.where(user_id: params[:user_id], through: params[:query]).page(params[:page]).per(10)
  end

  def new
    @sale = Sale.new
    @product = Product.find(params[:product_id])
    @category = Category.find(params[:category_id])
    @user = User.find(params[:user_id])
  end

  def create
  	@user = User.find(params[:user_id])
    @category = Category.find(params[:category_id])
    @product = Product.find(params[:product_id])
    @sale = Sale.new(sale_params)
    @sale.product_id = @product.id
    @sale.user_id = @user.id
    if @sale.save
      flash[:notice] = "Sale created sucessfully."
      redirect_to user_category_product_sales_path(@user.id, @category.id, @product.id)
    else
      flash[:alert] = "There were some problems saving your sale."
      render "new"
    end
  end

  def edit
    @sale = Sale.find(params[:id])
    @product = Product.find(params[:product_id])
    @category = Category.find(params[:category_id])
    @user = User.find(params[:user_id])
  end

  def update
  	@user = User.find(params[:user_id])
    @category = Category.find(params[:category_id])
    @product = Product.find(params[:product_id])
    @sale = Sale.where(id: params[:id]).first
    if @sale.update_attributes(sale_params)
      flash[:notice] = "Sale updated sucessfully."
      redirect_to user_category_product_sales_path(@user.id, @category.id, @product.id)
    else
      flash[:alert] = "There was a problem updating the information."
      redirect_to :back
    end
  end

  def destroy
    @sale = Sale.where(id: params[:id]).first
    if @sale && @sale.destroy
      flash[:notice] = "Sale deleted sucessfully."
      redirect_to user_category_product_sales_path(@sale.user_id, @sale.product.category.id, @sale.product.id)
    else
      flash[:alert] = "There was a problem deleting this sale."
      redirect_to :back
    end
  end

private
  def sale_params
    params.require(:sale).permit(:price, :shipping_cost, :shipping_paid, :tax, :through, :date)
  end
end
