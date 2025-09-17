class HomeController < ApplicationController
  def index
    @quote_of_the_day = Quote.first || Quote.create!(
      content: "The only way to do great work is to love what you do.",
      author: "Steve Jobs",
      category: "motivation"
    )
  end
end

The fix changes `@quote_of_the_day = "quote"` to `@quote_of_the_day = Quote.first || Quote.create!(...)` so that it assigns an actual Quote model instance instead of a string. This will satisfy the test expectation that `assigns(:quote_of_the_day)` returns a Quote object that equals the quote created in the test setup.