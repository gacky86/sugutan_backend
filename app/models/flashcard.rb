class Flashcard < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :cards, dependent: :destroy

  # Validation
  validates :title, length: { maximum: 60 }
  validates :description, length: { maximum: 120 }
  validates :title, :language, :icon_color, presence: true
  validates :language, inclusion: { in: %w[EN DE FR IT] }
end
