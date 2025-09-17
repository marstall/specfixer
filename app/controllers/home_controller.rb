class HomeController < ApplicationController
  def index
    @quote_of_the_day = Quote.daily_quote
  end

  def refresh_quote
    @quote_of_the_day = Quote.random_quote
    #render partial: 'quote_card', locals: { quote: @quote_of_the_day }
  end
end
