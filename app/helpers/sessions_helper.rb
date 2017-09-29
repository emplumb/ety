module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    session[:user_id] = nil
    reset_session
  end

  def admin_signed_in?
    current_user && current_user.admin
  end

  private
    def authenticate_admin!
      redirect_to :controller => 'terms', :action => 'show' unless current_user && current_user.admin
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
