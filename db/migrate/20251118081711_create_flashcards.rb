class CreateFlashcards < ActiveRecord::Migration[7.1]
  def change
    create_table :flashcards do |t|
      t.string :description
      t.string :title
      t.string :icon_color
      t.string :language
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
