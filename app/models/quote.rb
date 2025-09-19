class Quote < ActiveRecord::Base
  belongs_to :category

  validates :content, presence: true
  validates :author, presence: true

  scope :by_category, ->(category_name) { joins(:category).where(categories: { name: category_name }) }

  def self.random
    order('RANDOM()').first
  end

  def self.daily_quote
    # Use a deterministic seed based on the current date
    # This ensures the same quote is returned for the entire day
    seed = Date.current.strftime('%Y%m%d').to_i
    random_with_seed(seed)
  end

  def self.random_with_seed(seed)
    # Use the seed to get a consistent random quote for the day
    srand(seed)
    offset = rand(count)
    srand # Reset to random seed
    offset(offset).first
  end

  def formatted_display
    "\"#{content}\" - #{author}"
  end
end