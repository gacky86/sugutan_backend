class ExtraNote < ApplicationRecord
  NOTE_TYPES = %w[synonyms antonyms etymology collocations other].freeze
  # associations
  belongs_to :card

  # Validation
  validates :note_type, :content, presence: true
  validates :content, length: { maximum: 256 }
  validates :note_type, inclusion: { in: NOTE_TYPES, allow_blank: true }
end
