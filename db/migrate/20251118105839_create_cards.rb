class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.string :front
      t.string :back
      t.text :front_sentence
      t.text :back_sentence
      t.text :explanation
      t.references :flashcard, null: false, foreign_key: true

      t.timestamps
    end
  end
end
