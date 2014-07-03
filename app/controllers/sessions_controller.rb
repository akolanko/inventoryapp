class SessionsController < ApplicationController
  def new
  end

  def create
  	@user = User.find_by_email(params[:email])
  	if @user && @user.authenticate(params[:password])
      if params[:remember_me]
  		  cookies.permanent[:auth_token] = @user.auth_token
      else
        cookies[:auth_token] = @user.auth_token
      end
  		redirect_to root_path, :notice => "Welcome back #{@user.username}"
  	else
  		flash[:alert] = "There was a problem signing you in."
  		render "new"
  	end
  end

  def destroy
  	cookies.delete(:auth_token)
  	flash[:notice] = "You have been signed out."
  	redirect_to root_path
  end
end