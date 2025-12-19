class Card < ApplicationRecord
  # Associations
  belongs_to :flashcard
  has_many :extra_notes, dependent: :destroy
  has_many :card_progresses, dependent: :destroy

  # Validation
  validates :front, :back, :front_sentence, :back_sentence, :card_type, presence: true
  validates :front, :back, length: { maximum: 60 }
  validates :front_sentence, :back_sentence, length: { maximum: 256 }
  validates :explanation_front, :explanation_back, length: { maximum: 256 }
end
