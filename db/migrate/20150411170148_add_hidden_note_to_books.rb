class AddHiddenNoteToBooks < ActiveRecord::Migration
  def up
  	add_column :books, :hidden_note, :text
  end

  def down
  	remove_column :books, :hidden_note
  end
end
