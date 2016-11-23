class SessionController < ApplicationController

  def new
    if logged_in? redirect_to '/languages'

    render :new
  end

  def create
    if logged_in? redirect_to '/languages'

    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to "/users/#{session[:user_id]}"
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to 'session_new_path'
  end


end
