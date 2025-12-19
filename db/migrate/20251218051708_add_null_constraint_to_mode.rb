class AddNullConstraintToMode < ActiveRecord::Migration[7.1]
  def change
    change_column_null :card_progresses, :mode, false, "input"
  end
end
