class HomeController < ApplicationController
  def refresh_quote
    @quote_of_the_day = Quote.random
    
    respond_to do |format|
      format.js { render partial: 'quote_card' }
      format.html { redirect_to root_path }
    end
  end
end