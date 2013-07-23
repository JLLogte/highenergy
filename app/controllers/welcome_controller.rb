class WelcomeController < ApplicationController

  def index
    if user_signed_in?
      #get a list of recent articles based on what user is sub'd to
      @articles = current_user.get_articles
    else
      #get a list of most recent articles from all topics
      @articles = Article.order("created_at DESC").limit(10)
    end
  end
end
