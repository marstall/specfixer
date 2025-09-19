FactoryBot.define do
  factory :quote do
    content { "Sample quote content" }
    author { "Sample Author" }
    category { "general" }

    trait :inspiration do
      content { "Test refresh quote" }
      author { "Test Author" }
      category { "inspiration" }
    end
  end
end