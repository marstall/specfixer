class Quote < ActiveRecord::Base
  validates :content, presence: true
  validates :author, presence: true

  def self.daily_quote
    # Return a consistent quote for the day based on date
    # This ensures the same quote is shown throughout the day
    date_seed = Date.current.strftime("%Y%m%d").to_i
    quotes = all.to_a
    return create_default_quote if quotes.empty?
    
    quotes[date_seed % quotes.length]
  end

  def self.random
    # Return a random quote
    quotes = all.to_a
    return create_default_quote if quotes.empty?
    
    quotes.sample
  end

  private

  def self.create_default_quote
    new(
      content: "No quotes available at the moment.",
      author: "SpecFixer System"
    )
  end
end