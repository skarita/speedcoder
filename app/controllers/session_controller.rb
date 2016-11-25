class SessionController < ApplicationController

  def new
    render :new
  end

  def create
    user = User.find_by(email: params[:email])
    if !!user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Logged in successfully"
      redirect_to "/users/#{session[:user_id]}"
    else
      redirect_to session_new_path, danger: "Login or password incorrect. Try again"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to session_new_path
  end


end
