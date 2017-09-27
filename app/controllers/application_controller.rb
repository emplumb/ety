class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :session_expired?

  rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def admin_signed_in?
    current_user && current_user.admin
  end
  helper_method :admin_signed_in?

  private
    def authenticate_admin!
      redirect_to :controller => 'terms', :action => 'show' unless current_user && current_user.admin
    end

    def record_not_unique
      flash[:danger] = "You are attempting to save an entry with the same url (slug) as an existing one. Please check your records and choose a new name.

        <br />
        <br />

        Note: punctuation, spaces, parentheses, and other special characters are removed from the url when saving"
      redirect_back(fallback_location: root_path)
    end

    def session_expired?
      if !session[:expiry_time].nil? && session[:expiry_time] < Time.now
        session[:user_id] = nil
        reset_session
        redirect_to :controller => 'sessions', :action => 'new'
        flash[:warning] = 'The session has timed out due to inactivity'
      end
      session[:expiry_time] = 30.minutes.from_now
    end
end
