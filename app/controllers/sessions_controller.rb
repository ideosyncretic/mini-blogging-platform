class SessionsController < ApplicationController
  # session is triggered after user login

  def new
  end

  def create
    # firstly, find user by email
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
    # if user.try(:authenticate, params[:password])
      # successful login
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Logged In'
    else
      flash.now.alert = 'invalid login details'
      # displays immediately
      render 'new'
      # immediate, not new request
    end
  end

  def destroy
    # log out user
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged Out'
  end
end
