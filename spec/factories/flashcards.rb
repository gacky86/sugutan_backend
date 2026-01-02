FactoryBot.define do
  factory :flashcard do
    description { "english words in daily life" }
    title { "english words" }
    icon_color { "red" }
    language { "EN" }
    user { nil }
  end
end
