class Quote < ApplicationRecord
  validates :content, presence: true
  validates :author, presence: true
  validates :category, presence: true

  scope :by_category, ->(category) { where(category: category) }

  def self.daily_quote
    random_quote
  end

  def self.random_quote
    quote = all.sample
    quote || create_default_quote
  end

  def self.create_default_quote
    create!(
      content: "The only way to do great work is to love what you do.",
      author: "Steve Jobs",
      category: "motivation"
    )
  end

  def formatted_display
    "\"#{content}\" — #{author}"
  end
end