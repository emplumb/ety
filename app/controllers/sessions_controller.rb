class SessionsController < ApplicationController
  def new
    if !current_user.nil?
      flash[:info] = 'You are already logged in'
      redirect_to '/'
    end
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password]) && !params[:fax].present?
      reset_session
      log_in user
      params[:remember_me] == '1' ? remember(user) : forget(user)
      flash[:success] = 'Successfully logged in'
      redirect_to '/'
    else
      flash[:danger] = 'Invalid username or password'
      redirect_to '/login'
    end
  end

  def destroy
    if logged_in?
      log_out
      flash[:warning] = 'Successfully logged out'
      redirect_to '/login'
    else
      flash[:info] = 'You are already logged out'
      redirect_to '/'
    end
  end
end
