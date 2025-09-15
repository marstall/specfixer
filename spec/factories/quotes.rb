FactoryBot.define do
  factory :quote do
    content { "The only way to do great work is to love what you do." }
    author { "Steve Jobs" }
    category { "motivation" }

    trait :inspiration do
      content { "It is during our darkest moments that we must focus to see the light." }
      author { "Aristotle" }
      category { "inspiration" }
    end

    trait :success do
      content { "Success is not final, failure is not fatal: it is the courage to continue that counts." }
      author { "Winston Churchill" }
      category { "success" }
    end

    trait :wisdom do
      content { "Don't let yesterday take up too much of today." }
      author { "Will Rogers" }
      category { "wisdom" }
    end
  end
end
