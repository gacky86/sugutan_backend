class AddPronunciationToCards < ActiveRecord::Migration[7.1]
  def change
    add_column :cards, :pronunciation, :string
  end
end
