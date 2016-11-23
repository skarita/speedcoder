class UsersController < ApplicationController
  def home
  end

  def show
    @user = User.find(params[:id])
    if !@user
      redirect_to '/'
    end
    wpm_total = Attempt.where(user_id: @user.id).order('id DESC').limit(10).map{ |attempt| attempt.score }.sum
    attempt_count = Attempt.where(user_id: @user.id).order('id DESC').limit(10).count

    @attempts = Attempt.where(user_id: @user.id).order('id DESC').limit(10)
    @snippets = Snippet.where(user_id: @user.id).order('id DESC')
    if attempt_count > 0
      @wpm = wpm_total / attempt_count
    end

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
      if user.errors[:email][0] != nil
        @errors = "Email #{user.errors[:email][0]}"
      end
      if user.errors[:username][0] != nil
        @errors = "Username #{user.errors[:username][0]}"
      end
      if user.errors[:name][0] != nil
        @errors = "Name #{user.errors[:name][0]}"
      end
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
