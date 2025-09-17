class HomeController < ApplicationController
  def index
    @quote_of_the_day = Quote.first
  end
end

The fix changes the assignment from a string literal `"quote"` to `Quote.first`, which will return the first Quote record from the database, matching what the test expects.