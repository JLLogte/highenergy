class WelcomeController < ApplicationController

  def index
  	if user_signed_in?
      @articles = Array.new
  	 Game.all.each do |game|
  	   @articles << game.articles if current_user.is_subscribed?(game)
      end
      @articles.flatten!
  	end
  end

end
