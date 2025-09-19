class Quote < ActiveRecord::Base
  validates :content, presence: true
  validates :author, presence: true
  validates :category, presence: true

  scope :by_category, ->(category) { where(category: category) }

  def self.daily_quote
    return create_default_quote if count.zero?
    
    # Use date-based seeding for consistency
    date_seed = Date.current.strftime("%Y%m%d").to_i
    Random.srand(date_seed)
    offset = Random.rand(count)
    Random.srand # Reset to random seed
    
    offset(offset).first
  end

  def self.random_quote
    return create_default_quote if count.zero?
    
    offset(rand(count)).first
  end

  def self.create_default_quote
    create!(
      content: "The only way to do great work is to love what you do.",
      author: "Steve Jobs",
      category: "inspiration"
    )
  end

  def formatted_display
    "\"#{content}\" - #{author}"
  end
end