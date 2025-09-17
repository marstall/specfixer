class HomeController < ApplicationController
  def index
    @quote_of_the_day = Quote.daily_quote
  end

  def refresh_quote
    @quote_of_the_day = Quote.random_quote
    render partial: 'quote_card', locals: { quote: @quote_of_the_day }
  end
end

The fix is simple - I uncommented the line `@quote_of_the_day = Quote.random_quote` in the `refresh_quote` method. This will:

1. Fix the controller spec failures that expect `@quote_of_the_day` to be assigned
2. Fix the spec that expects `Quote.random_quote` to be called
3. Fix the feature spec that expects the quote content to be displayed properly

The tests are failing because:
- The instance variable `@quote_of_the_day` is not being set (returns `nil`)
- The `Quote.random_quote` method is never called
- The partial rendering doesn't have the expected quote data to display