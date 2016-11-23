class UsersController < ApplicationController
  def home
  end

  def show
    @user = User.find(params[:id])
    if !@user
      redirect_to '/'
    end
    wpm_total = Attempt.where(user_id: @user.id).order('id DESC').limit(10).map{ |attempt| attempt.score }.sum
    @wpm = wpm_total / 10
    @attempts = Attempt.where(user_id: @user.id).order('id DESC').limit(10)
    @snippets = Snippet.where(user_id: @user.id)
  end

  def new
  end

  def create
    user = User.new
    user.email = params[:email]
    user.name = params[:name]
    user.username = params[:username]
    user.password = params[:password]

    if user.save
      session[:user_id] = user.id
      redirect_to '/languages'
    else
      render :new
    end
  end

  def edit
    if session[:user_id] != params[:id].to_i
      redirect_to '/'
    end

    @user = User.find(params[:id])
  end

  def update
    if session[:user_id] != params[:id].to_i
      redirect_to '/'
    end

    user = User.find(params[:id])
    user.email = params[:email]
    user.name = params[:name]
    user.username = params[:username]
    if params[:password] != ''
      user.password = params[:password]
    end
    
    if user.save
      redirect_to "/users/#{session[:user_id]}"
    else
      render :edit
    end
  end

  def destroy
    if session[:user_id] != params[:id].to_i
      redirect_to '/'
    end
    
    user = User.find(params[:id])
    user.destroy
    redirect_to "/users/#{session[:user_id]}"
  end

end
