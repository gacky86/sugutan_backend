FactoryBot.define do
  factory :card do
    front { "MyString" }
    back { "MyString" }
    front_sentence { "MyText" }
    back_sentence { "MyText" }
    explanation { "MyText" }
    flashcard { nil }
  end
end
