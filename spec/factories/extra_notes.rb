FactoryBot.define do
  factory :extra_note do
    note_type { "MyString" }
    content { "MyText" }
    card { nil }
  end
end
