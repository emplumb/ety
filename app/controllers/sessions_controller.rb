class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      reset_session
      session[:user_id] = user.id
      remember user
      flash[:success] = 'Successfully logged in'
      redirect_to '/'
    else
      flash[:warning] = 'Invalid username or password'
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    reset_session
    flash[:success] = 'Successfully logged out'
    redirect_to '/login'
  end
end
