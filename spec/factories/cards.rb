FactoryBot.define do
  factory :card do
    front { "単語" }
    back { "word" }
    front_sentence { "単語を使った例文" }
    back_sentence { "A sentence using the word" }
    explanation { "単語の説明" }
    pronunciation { "単語の発音" }
    card_type { "noun" }
    flashcard
  end
end
