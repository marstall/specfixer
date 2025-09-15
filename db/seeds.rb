# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create sample quotes for the Quote of the Day feature
quotes_data = [
  {
    content: "The only way to do great work is to love what you do.",
    author: "Steve Jobs",
    category: "motivation"
  },
  {
    content: "Innovation distinguishes between a leader and a follower.",
    author: "Steve Jobs",
    category: "innovation"
  },
  {
    content: "Life is what happens to you while you're busy making other plans.",
    author: "John Lennon",
    category: "life"
  },
  {
    content: "The future belongs to those who believe in the beauty of their dreams.",
    author: "Eleanor Roosevelt",
    category: "dreams"
  },
  {
    content: "It is during our darkest moments that we must focus to see the light.",
    author: "Aristotle",
    category: "inspiration"
  },
  {
    content: "Success is not final, failure is not fatal: it is the courage to continue that counts.",
    author: "Winston Churchill",
    category: "success"
  },
  {
    content: "The way to get started is to quit talking and begin doing.",
    author: "Walt Disney",
    category: "action"
  },
  {
    content: "Don't let yesterday take up too much of today.",
    author: "Will Rogers",
    category: "wisdom"
  },
  {
    content: "You learn more from failure than from success. Don't let it stop you. Failure builds character.",
    author: "Unknown",
    category: "failure"
  },
  {
    content: "If you are working on something that you really care about, you don't have to be pushed. The vision pulls you.",
    author: "Steve Jobs",
    category: "passion"
  },
  {
    content: "Experience is a hard teacher because she gives the test first, the lesson afterward.",
    author: "Vernon Law",
    category: "learning"
  },
  {
    content: "The only impossible journey is the one you never begin.",
    author: "Tony Robbins",
    category: "journey"
  }
]

quotes_data.each do |quote_attrs|
  Quote.find_or_create_by!(
    content: quote_attrs[:content],
    author: quote_attrs[:author]
  ) do |quote|
    quote.category = quote_attrs[:category]
  end
end

puts "Created #{Quote.count} quotes in the database."
