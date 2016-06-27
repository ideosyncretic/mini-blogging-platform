class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # declare methods as helper methods so they are accessible from views
  helper_method :current_user
  helper_method :user_logged_in?

  def current_user
    # @c_user ||= User.find( session[:user_id] ) unless session[:user_id].blank?
    User.find( session[:user_id] ) unless session[:user_id].blank?
  end

  def user_logged_in?
    current_user.present?
  end

  def authenticate_user
    unless user_logged_in?
      flash[:error] = 'Please login first!'
      redirect_to login_url
      # use _url inside controllers and _path in views
    end
  end
end
