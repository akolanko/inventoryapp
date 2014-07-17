class UsersController < ApplicationController
  def index
  	@users = User.all
  end

  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	@user.update_attributes(admin: false)
  	if @user.save
  		flash[:notice] = "Account created sucessfully."
      cookies[:auth_token] = @user.auth_token
  		redirect_to root_path
  	else
  		flash[:alert] = "There were some problems with your submission."
  		render "new"
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.where(id: params[:id]).first
    if @user.update_attributes(user_params)
      flash[:notice] = "Information saved sucessfully."
      redirect_to user_path(@user.id)
    else
      flash[:alert] = "There was a problem updating the information."
      redirect_to :back
    end
  end

  def password
    @user = User.where(id: params[:id]).first
    if @user.update_attributes(user_params)
      flash[:notice] = "Password updated sucessfully."
      redirect_to user_path(@user.id)
    else
      flash[:alert] = "There was a problem updating the information."
      redirect_to :back
    end
  end

  def destroy
  	@user = User.where(id: params[:id]).first
  	if @user && @user.destroy
  		cookies.delete(auth_token)
  		flash[:notice] = "Account deleted sucessfully."
  		redirect_to root_path
  	else
  		flash[:alert] = "There was a problem deleting this account."
  		redirect_to :back
  	end
  end

 private
  def user_params
    params.require(:user).permit(:email, :email_confirmation, :username, :password, :password_confirmation, :admin)
  end

end
