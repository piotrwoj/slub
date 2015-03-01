class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.text :description
      t.boolean :reserved, default: false
      t.string :author

      t.timestamps null: false
    end
  end
end
