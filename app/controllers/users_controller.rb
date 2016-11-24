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
    else
      @wpm = "-"
    end
  end

  def new
    @errors = {}
  end

  def create
    @user = User.new
    @user.email = params[:email]
    @user.name = params[:name]
    @user.username = params[:username]
    @user.password = params[:password]

    @errors = {}
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Signed up successfully"

      redirect_to '/languages'
    else
      flash[:danger] = "Something went wrong. Try again."
      @user.errors.messages.each do |key, value|
        if value.any?
          @errors[key] = '*' + value.join(', ')
        end
      end
      render :new
    end
  end

  def edit
    if session[:user_id] != params[:id].to_i
      redirect_to '/'
    end

    @user = User.find(params[:id])
    @errors = {}
  end

  def update
    if session[:user_id] != params[:id].to_i
      redirect_to '/'
    end

    @user = User.find(params[:id])
    if @user.email != params[:email]
      @user.email = params[:email]
    end
    if @user.name != params[:name]
      @user.name = params[:name]
    end
    if @user.username != params[:username]
      @user.username = params[:username]
    end
    if params[:password] != ''
      @user.password = params[:password]
    end

    @errors = {}
    if @user.save
      flash[:success] = "Your account was updated successfully"
      redirect_to "/users/#{session[:user_id]}"
    else
      flash[:danger] = "Something went wrong. Try again."
      @user.errors.messages.each do |key, value|
        if value.any?
          @errors[key] = '*' + value.join(', ')
        end
      end
      render :edit
    end
  end

  def destroy
    if session[:user_id] != params[:id].to_i
      redirect_to '/'
    end

    user = User.find(params[:id])
    user.destroy
    flash[:warning] = "Your account was deleted successfully"
    redirect_to "/users/#{session[:user_id]}"
  end

end
