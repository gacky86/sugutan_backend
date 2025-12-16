class CardProgress < ApplicationRecord
  belongs_to :user
  belongs_to :card

  validates :card_id, uniqueness: { scope: :user_id }
end
