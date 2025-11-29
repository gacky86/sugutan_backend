class AddColumnCards < ActiveRecord::Migration[7.1]
  def change
    add_column :cards, :explanation_front, :text
    add_column :cards, :explanation_back, :text
    add_column :cards, :card_type, :string
    remove_column :cards, :explanation;
  end
end
