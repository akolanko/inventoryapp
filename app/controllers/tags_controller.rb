class TagsController < ApplicationController
  def index
  	@product = Product.find(params[:product_id])
    @category = Category.find(params[:category_id])
    @user = User.find(params[:user_id])
    @tag = Tag.new
    @tags = Tag.where(user_id: params[:user_id], product_id: params[:product_id]).all
  end

  def search
  	@user = User.find(params[:user_id])
    @tags = Tag.where(user_id: params[:user_id], name: params[:query].to_s.downcase).page(params[:page]).per(10)
  end

  def new
  	@tag = Tag.new
    @product = Product.find(params[:product_id])
    @category = Category.find(params[:category_id])
    @user = User.find(params[:user_id])
  end

  def create
	@user = User.find(params[:user_id])
    @category = Category.find(params[:category_id])
    @product = Product.find(params[:product_id])
    @tag = Tag.new(tag_params)
    @tag.update_attributes(name: @tag.name.downcase)
    @tag.product_id = @product.id
    @tag.user_id = @user.id
    if @tag.save
      flash[:notice] = "Tag added sucessfully."
      redirect_to user_category_product_tags_path(@user.id, @category.id, @product.id)
    else
      flash[:alert] = "There were some problems saving your tag."
      render "new"
    end
  end

  def destroy
    @tag = Tag.where(id: params[:id]).first
    if @tag && @tag.destroy
      flash[:notice] = "Tag deleted sucessfully."
      redirect_to user_category_product_tags_path(@tag.user_id, @tag.product.category.id, @tag.product.id)
    else
      flash[:alert] = "There was a problem deleting this tag."
      redirect_to :back
    end
  end

private
  def tag_params
    params.require(:tag).permit(:name)
  end

end
