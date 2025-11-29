class CreateExtraNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :extra_notes do |t|
      t.string :note_type
      t.text :content
      t.references :card, null: false, foreign_key: true

      t.timestamps
    end
  end
end
