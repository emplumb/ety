class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      reset_session
      log_in user
      remember user
      flash[:success] = 'Successfully logged in'
      redirect_to '/'
    else
      flash[:warning] = 'Invalid username or password'
      redirect_to '/login'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:warning] = 'Successfully logged out'
    redirect_to '/login'
  end
end
