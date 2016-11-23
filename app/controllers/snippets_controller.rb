class SnippetsController < ApplicationController

  def show
    @snippet = Snippet.find(params[:id])
    body = @snippet.body.delete("\r")
    @array = body.split("").push(" ")

    if @snippet.language == 'javascript'
      @header_snippet_name = @snippet.name.gsub(/\s/, '_') + '.js'
    elsif @snippet.language == 'ruby'
      @header_snippet_name = @snippet.name.gsub(/\s/, '_') + '.rb'
    else
      @header_snippet_name = @snippet.name
    end

    if !!session[:user_id]
      @history = Attempt.where('user_id' => User.find(session[:user_id]).id, 'snippet_id' => @snippet.id).limit(3)
    end

    @leaderboard = Attempt.where('snippet_id' => @snippet.id).order('score DESC').limit(10)

  end

  def new

  end

  def create
    snippet = Snippet.new
    snippet.description = params[:description]
    snippet.name = params[:name]
    snippet.user_id = session[:user_id]
    snippet.body = params[:body].split("\n").map do |line|
                      line.rstrip
                  end.join("\n").strip
    snippet.language = params[:language]
    snippet.word_count = snippet.body.scan(/[[:alpha:]]+/).count

    if snippet.save
      redirect_to "/snippets/#{snippet.id}"
    else
      render :new
    end
  end

  def edit
    @snippet = Snippet.find(params[:id])

    if session[:user_id] != @snippet.user_id
      redirect_to '/'
    end

  end

  def update
    @snippet = Snippet.find(params[:id])

    if session[:user_id] != @snippet.user_id
      redirect_to '/'
    end

    @snippet.description = params[:description]
    @snippet.name = params[:name]
    @snippet.user_id = session[:user_id]
    @snippet.body = params[:body].split("\n").map do |line|
                      line.rstrip
                  end.join("\n").strip
    @snippet.language = params[:language]
    @snippet.word_count = @snippet.body.scan(/[[:alpha:]]+/).count
    if @snippet.save
      redirect_to "/snippets/#{@snippet.id}"
    else
      render :edit
    end
  end

  def destroy
    snippet = Snippet.find(params[:id])
    if session[:user_id] != snippet.user_id
      redirect_to '/'
    end
    snippet.destroy
    redirect_to "/users/#{session[:user_id]}"
  end

  def languages
    @snippets = Snippet.all
    @attempts = Attempt.order(score: :desc).limit(10)
  end

  def javascript
    @snippets_JS = Snippet.where(language: 'javascript')
    @snippets_pop = Snippet.joins(:attempts).where(language: 'javascript').group(:id).order("count(*) desc")
    @attempts_JS = Attempt.joins(:snippet).where(snippets: {language: :javascript }).order(score: :desc).limit(10)
  end

  def ruby
    @snippets_rb = Snippet.where(language: 'ruby')
    @snippets_pop = Snippet.joins(:attempts).where(language: 'ruby').group(:id).order("count(*) desc")
    @attempts_rb = Attempt.joins(:snippet).where(snippets: {language: :ruby }).order(score: :desc).limit(10)
  end

  def others
    @snippets_other = Snippet.where(language: 'other')
    @snippets_pop = Snippet.joins(:attempts).where(language: 'other').group(:id).order("count(*) desc")
    @attempts_other = Attempt.joins(:snippet).where(snippets: {language: :other }).order(score: :desc).limit(10)
  end
end
