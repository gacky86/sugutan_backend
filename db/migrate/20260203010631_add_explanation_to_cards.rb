class AddExplanationToCards < ActiveRecord::Migration[7.1]
  def change
    add_column :cards, :explanation, :text
  end
end
