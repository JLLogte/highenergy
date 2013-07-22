class WelcomeController < ApplicationController

  def index
  	if user_signed_in?
      @articles = Array.new
  	 Game.last(10).each do |game|
  	   @articles << game.articles if current_user.is_subscribed?(game)
      end
      @articles.flatten!
  	else
      @articles = Article.all
    end
  end

end
