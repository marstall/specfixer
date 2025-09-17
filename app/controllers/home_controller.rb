class HomeController < ApplicationController
  def index
    @quote_of_the_day = QuoteOfTheDay.current_quote
  end

  def refresh_quote
    @quote_of_the_day = QuoteOfTheDay.current_quote
    
    if request.xhr?
      render partial: 'quote_card'
    else
      render :index
    end
  end
end