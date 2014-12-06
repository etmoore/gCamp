class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :ensure_logged_in

  def current_user
    User.find_by(id: session[:user_id])
  end

  helper_method :current_user

  def ensure_logged_in
    redirect_to signin_path, notice: 'You must be logged in to access that action' unless current_user
  end

end
