class SnippetsController < ApplicationController

  def home
  end

  def show
    @snippet = Snippet.find(params[:id])
    body = @snippet.body.delete("\r")
    @array = body.split("").map do |char|
      char = char
    end
    # raise
  end

  def new

  end

  def create
    snippet = Snippet.new
    snippet.description = params[:description]
    snippet.name = params[:name]
    snippet.user_id = session[:user_id]
    snippet.body = params[:body]
    snippet.language = params[:language]
    snippet.word_count = params[:word_count]

    if snippet.save
      redirect_to "/snippets"
    else
      render :new
    end
  end

  def edit
    @snippet = Snippet.find(params[:id])
  end

  def update
    snippet = Snippet.new
    snippet.description = params[:description]
    snippet.name = params[:name]
    snippet.user_id = params[:user_id]
    snippet.body = params[:body]
    snippet.language = params[:language]
    snippet.word_count = params[:word_count]

    if snippet.save
      redirect_to "/snippets"
    else
      render :edit
    end
  end

  def destroy
    snippet = Snippet.find(params[:id])
    snippet.destroy
    redirect_to "/snippets"
  end
end
