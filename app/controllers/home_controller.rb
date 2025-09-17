class HomeController < ApplicationController
  def index
    @quote_of_the_day = Quote.random
  end

  def refresh_quote
    @quote_of_the_day = Quote.random
    
    if request.xhr?
      render partial: 'quote_card'
    else
      redirect_to root_path
    end
  end
end