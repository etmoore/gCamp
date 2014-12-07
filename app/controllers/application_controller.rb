class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_signin

  def current_user
    User.find_by(id: session[:user_id])
  end

  helper_method :current_user

  def require_signin
    redirect_to signin_path, notice: 'You must be logged in to access that action' unless current_user
  end

  class AccessDenied < StandardError
  end
  rescue_from AccessDenied, with :render_404

  def render_404
    render 'public/404', status: :not_found, layout: false
  end

end
