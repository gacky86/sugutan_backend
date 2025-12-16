class CreateCardProgresses < ActiveRecord::Migration[7.1]
  def change
    create_table :card_progresses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :card, null: false, foreign_key: true
      t.integer :interval_days, default: 1, null: false
      t.datetime :next_review_at, null: false
      t.integer :review_count, default: 0, null: false
      t.float :easiness_factor
      t.datetime :last_reviewed_at

      t.timestamps
    end
    add_index :card_progresses, [:user_id, :card_id], unique: true
  end
end
