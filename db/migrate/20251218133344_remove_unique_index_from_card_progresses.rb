class RemoveUniqueIndexFromCardProgresses < ActiveRecord::Migration[7.1]
  def change
    remove_index :card_progresses, name: "index_card_progresses_on_user_id_and_card_id"
  end
end
