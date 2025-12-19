class AddModeToCardProgresses < ActiveRecord::Migration[7.1]
  def change
    add_column :card_progresses, :mode, :text
    add_index :card_progresses, [:user_id, :card_id, :mode], unique: true
  end
end
