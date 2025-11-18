class AddDefaultValueToFlashcardsLanguage < ActiveRecord::Migration[7.1]
  def change
    change_column_default :flashcards, :language, "EN"
  end
end
