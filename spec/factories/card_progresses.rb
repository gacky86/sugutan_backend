FactoryBot.define do
  factory :card_progress do
    user
    card
    interval_days { 1 }
    next_review_at { "2025-12-16 11:19:57" }
    review_count { 1 }
    easiness_factor { 1.5 }
    last_reviewed_at { "2025-12-16 11:19:57" }
  end
end
