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
      @history = Attempt.where('user_id' => User.find(session[:user_id]).id, 'snippet_id' => @snippet.id).order('id DESC').limit(3)

      @time_played = []
      @history.each do |attempt|

        sec_diff = (Time.zone.now - attempt.updated_at).floor
        minute_diff = (sec_diff / 60).floor
        hour_diff = (minute_diff / 60).floor
        day_diff = (hour_diff / 24).floor
        year_diff = (day_diff / 365).floor

        if sec_diff < 2
          time_string = "#{sec_diff} second ago"
        elsif sec_diff < 60
          time_string = "#{sec_diff} seconds ago"
        elsif minute_diff < 2
          time_string = "#{minute_diff} minute ago"
        elsif minute_diff < 60
          time_string = "#{minute_diff} minutes ago"
        elsif hour_diff < 2
          time_string = "#{hour_diff} hour ago"
        elsif hour_diff < 24
          time_string = "#{hour_diff} hours ago"
        elsif day_diff < 2
          time_string = "#{day_diff} day ago"
        elsif day_diff < 365
          time_string = "#{day_diff} days ago"
        elsif year_diff < 2
          time_string = "#{year_diff} year ago"
        else
          time_string = "#{year_diff} years ago"
        end

        @time_played.push(time_string)
      end
    end

    @leaderboard = Attempt.where('snippet_id' => @snippet.id).order('score DESC').to_a.uniq {|attempt| attempt[:user_id] }[0,10]

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
      flash[:success] = "Snippet added successfully"
      redirect_to "/snippets/#{snippet.id}"
    else
      flash[:danger] = "Something went wrong. Try again"
      render :new
    end
  end

  def edit
    @snippet = Snippet.find(params[:id])

    if session[:user_id] != @snippet.user_id
      flash[:success] = "Snippet added successfully"
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
      flash[:success] = "Snippet updated successfully"
      redirect_to "/snippets/#{@snippet.id}"
    else
      flash[:danger] = "Something went wrong. Try again"
      render :edit
    end
  end

  def destroy
    snippet = Snippet.find(params[:id])
    if session[:user_id] != snippet.user_id
      redirect_to '/'
    end
    snippet.destroy
    flash[:success] = "Snippet removed successfully"
    redirect_to "/users/#{session[:user_id]}"
  end

  def languages
    @snippets = Snippet.all
    @attempts = Attempt.order(score: :desc).to_a.uniq {|attempt|  [attempt[:user_id],attempt[:snippet_id]]  }[0,10]
  end

  def javascript
    @snippets = Snippet.where(language: 'javascript')
    @snippets_pop = Snippet.joins(:attempts).where(language: 'javascript').group(:id).order("count(*) desc")
    @attempts = Attempt.joins(:snippet).where(snippets: {language: :javascript }).order(score: :desc).to_a.uniq {|attempt|  [attempt[:user_id],attempt[:snippet_id]]  }[0,10]
  end

  def ruby
    @snippets = Snippet.where(language: 'ruby')
    @snippets_pop = Snippet.joins(:attempts).where(language: 'ruby').group(:id).order("count(*) desc")
    @attempts = Attempt.joins(:snippet).where(snippets: {language: :ruby }).order(score: :desc).to_a.uniq {|attempt|  [attempt[:user_id],attempt[:snippet_id]]  }[0,10]
  end

  def others
    @snippets = Snippet.where(language: 'other')
    @snippets_pop = Snippet.joins(:attempts).where(language: 'other').group(:id).order("count(*) desc")
    @attempts = Attempt.joins(:snippet).where(snippets: {language: :other }).order(score: :desc).to_a.uniq {|attempt|  [attempt[:user_id],attempt[:snippet_id]]  }[0,10]
  end
end
