FactoryBot.define do
  factory :card do
    front { "単語" }
    back { "word" }
    front_sentence { "単語を使った例文" }
    back_sentence { "A sentence using the word" }
    explanation_front { "単語の説明" }
    explanation_back { "explanation of the word" }
    card_type { "noun" }
    flashcard
  end
end
