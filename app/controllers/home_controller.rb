class HomeController < ApplicationController
  def index
    @quote_of_the_day = Quote.random_quote
  end

  def refresh_quote
    @quote_of_the_day = Quote.random_quote
    
    if request.xhr?
      render json: {
        content: @quote_of_the_day&.content || "No quotes available at the moment.",
        author: @quote_of_the_day&.author || "SpecFixer System"
      }
    else
      redirect_to root_path
    end
  end
end