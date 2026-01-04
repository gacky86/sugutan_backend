FactoryBot.define do
  factory :extra_note do
    note_type { "synonyms" }
    content { "test content" }
    card
  end
end
