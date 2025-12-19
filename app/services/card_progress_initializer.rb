class CardProgressInitializer
  DEFAULT_INTERVAL_DAYS = 1
  DEFAULT_EF = 2.5
  def self.call(user:, card:, mode:)
    CardProgress.find_or_create_by!(user: user, card: card, mode: mode) do |progress|
      progress.interval_days = DEFAULT_INTERVAL_DAYS
      progress.review_count  = 0
      progress.easiness_factor = DEFAULT_EF
      progress.next_review_at = Time.current
    end
  rescue ActiveRecord::RecordNotUnique
    CardProgress.find_by(user: user, card: card, mode: mode)
  end
end
