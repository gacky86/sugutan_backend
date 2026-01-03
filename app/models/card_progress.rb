class CardProgress < ApplicationRecord
  SUCCESS_MULTIPLIER = 2
  MIN_INTERVAL_DAYS = 1

  DIFFICULTY_TO_QUALITY = {
    "again" => 1, # もう一度
    "hard" => 3, # 難しい
    "normal" => 4, # 普通
    "easy" => 5 # 簡単
  }.freeze

  belongs_to :user
  belongs_to :card

  validates :card_id, uniqueness: { scope: [:user_id, :mode] }
  validates :interval_days, :next_review_at, :review_count, :mode, presence: true

  enum :mode, {
    input: "input",
    output: "output"
  }

  def mark_review!(difficulty:)
    quality = DIFFICULTY_TO_QUALITY[difficulty]

    raise ArgumentError, "invalid difficulty" unless quality

    if quality < 3
      reset_progress!
    else
      advance_progress!(quality)
    end
  end

  def reset_progress!
    update!(
      interval_days: 1,
      last_reviewed_at: Time.current,
      next_review_at: 1.day.from_now
    )
  end

  def advance_progress!(quality)
    ef = easiness_factor || 2.5

    new_ef = ef + (0.1 - ((5 - quality) * (0.08 + ((5 - quality) * 0.02))))
    new_ef = [new_ef, 1.3].max

    new_interval =
      case review_count
      when 0 then 1
      when 1 then 6
      else (interval_days * new_ef).round
      end

    update!(
      interval_days: new_interval,
      review_count: review_count + 1,
      easiness_factor: new_ef,
      last_reviewed_at: Time.current,
      next_review_at: Time.current + new_interval.days
    )
  end

  # 学習モードごとのcard_progressに絞り込むscope
  scope :for_mode, ->(mode) { where(mode:) }

  scope :due, lambda {
    where(next_review_at: ..Time.current)
  }

  scope :ordered_by_due, lambda {
    order(next_review_at: :asc)
  }
end
