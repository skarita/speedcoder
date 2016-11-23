class SnippetsController < ApplicationController

  def show
    @snippet = Snippet.find(params[:id])
    body = @snippet.body.delete("\r")
    @array = body.split("").push(" ")
    # raise
  end

  def new

  end

  def create
    snippet = Snippet.new
    snippet.description = params[:description]
    snippet.name = params[:name]
    snippet.user_id = session[:user_id]
    snippet.body = params[:body].strip
    snippet.language = params[:language]
    snippet.word_count = snippet.body.scan(/[[:alpha:]]+/).count

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
    @snippet = Snippet.find(params[:id])
    @snippet.description = params[:description]
    @snippet.name = params[:name]
    @snippet.user_id = session[:user_id]
    @snippet.body = params[:body]
    @snippet.language = params[:language]
    @snippet.word_count = params[:word_count]
    if @snippet.save
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

  def languages
    @snippets = Snippet.all.limit(10)
    @attempts = Attempt.joins(:snippet).all.order(score: :desc).limit(10)

  end

  def javascript
    @snippets_JS = Snippet.where(language: 'javascript')
    @attempts_JS = Attempt.joins(:snippet).where(snippets: {language: :javascript }).order(score: :desc).limit(10)
  end

  def ruby
    @snippets_rb = Snippet.where(language: 'ruby')
    @attempts_rb = Attempt.joins(:snippet).where(snippets: {language: :ruby }).order(score: :desc).limit(10)
  end

  def others
    @snippets_other = Snippet.where(language: 'other')
    @attempts_other = Attempt.joins(:snippet).where(snippets: {language: :other }).order(score: :desc).limit(10)
  end
end
