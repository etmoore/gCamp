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
    unless current_user
      store_location
      redirect_to signin_path, notice: 'You must be logged in to access that action'
    end
  end

  class AccessDenied < StandardError
  end
  rescue_from AccessDenied, with: :render_404

  def render_404
    render 'public/404', status: 404, layout: false
  end

  def redirect_back(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  private

    def store_location
      session[:forwarding_url] = request.url if request.get?
    end

end
