class AttemptsController < ApplicationController

  def index
    @attempts = Attempt.all
    @attempts = Attempt.find(params[:id])
  end

  def show
    @attempts = Attempt.all
  end

  def create
    if logged_in?
      attempt = Attempt.new
      attempt.user_id = session[:user_id]
      attempt.snippet_id = params[:snippet_id]
      attempt.score = params[:score]
      attempt.accuracy = params[:accuracy]

      attempt.save
    end
  end

end
