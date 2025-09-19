class HomeController < ApplicationController
  def index
    @quote_of_the_day = Quote.random
  end

  def refresh_quote
    @quote_of_the_day = Quote.random
    
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { render partial: 'quote_card' }
    end
  end
end