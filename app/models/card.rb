class Card < ApplicationRecord
  # Associations
  belongs_to :flashcard

  # Validation
  validates :front, :back, length: { maximum: 255 }, presence: true
  validates :front_sentence, :back_sentence, :explanation, length: { maximum: 1000 }, presence: true
  validates :front, :back, length: { maximum: 255 }, presence: true
end
