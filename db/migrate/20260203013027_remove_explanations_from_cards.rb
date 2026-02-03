class RemoveExplanationsFromCards < ActiveRecord::Migration[7.1]
  def change
    remove_columns :cards, :explanation_front, :explanation_back, type: :text
  end
end
