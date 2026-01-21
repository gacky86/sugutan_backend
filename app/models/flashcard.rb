class Flashcard < ApplicationRecord
  LANGUAGE = %w[EN DE FR IT PO].freeze

  # Associations
  belongs_to :user
  has_many :cards, dependent: :destroy
  has_many :card_progresses, through: :cards

  # Validation
  validates :title, length: { maximum: 60 }
  validates :description, length: { maximum: 120 }
  validates :title, :language, :icon_color, presence: true
  validates :language, inclusion: { in: LANGUAGE, allow_blank: true }

  # 特定のFlashcardについて、属するCardの枚数(cards_count)、最終学習日(last_reviewed_at)を取得する
  scope :with_stats, lambda {
    left_joins(cards: :card_progresses)
      .select(
        "flashcards.*",
        "COUNT(DISTINCT cards.id) AS cards_count",
        "MAX(card_progresses.last_reviewed_at) AS last_reviewed_at"
      )
      .group("flashcards.id")
  }

  # with_statsを自動実行してlast_reviewed_atを取得し、date形式に変換する
  def last_reviewed_days_ago
    return nil unless last_reviewed_at

    (Date.current - last_reviewed_at.to_date).to_i
  end
end
