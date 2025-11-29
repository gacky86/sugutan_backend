class ExtraNote < ApplicationRecord
  belongs_to :card

  # Validation
  validates :note_type, :content, presence: true
end
