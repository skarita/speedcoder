class UsersController < ApplicationController
  def home
  end

  def show
    @user = User.find(params[:id])
    if !session[:user_id] && !!@user
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
      redirect_to '/snippets'
    else
      if user.errors[:email][0] != nil
        @errors = "Email #{user.errors[:email][0]}"
        render :new
      elsif user.errors[:username][0] != nil
        @errors = "Username #{user.errors[:username][0]}"
        render :new
      elsif user.errors[:name][0] != nil
        @errors = "Name #{user.errors[:name][0]}"
        render :new
      else
        render :new
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.email = params[:email]
    user.name = params[:name]
    user.username = params[:username]
    user.password = params[:password]
    if user.save
      redirect_to "/users/#{session[:user_id]}"
    else
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to "/users/#{session[:user_id]}"
  end

end
