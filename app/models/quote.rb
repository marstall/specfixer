class Quote < ApplicationRecord
  validates :content, presence: true
  validates :author, presence: true
  validates :category, presence: true

  scope :by_category, ->(category) { where(category: category) }

  def self.daily_quote
    # Get a consistent quote for the day based on the current date
    # This ensures the same quote is shown throughout the day
    date_seed = Date.current.strftime("%Y%m%d").to_i
    quotes = all.to_a
    return create_default_quote if quotes.empty?
    
    quotes[date_seed % quotes.length]
  end

  def self.random_quote
    # Get a truly random quote for the refresh functionality
    quotes = all.to_a
    return create_default_quote if quotes.empty?
    
    quotes.sample
  end

  def self.create_default_quote
    create!(
      content: "The only way to do great work is to love what you do.",
      author: "Steve Jobs",
      category: "motivation"
    )
  end

  def formatted_display
    "\"#{content}\" - #{author}"
  end
end
