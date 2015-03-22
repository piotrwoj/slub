class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.string :ip
      t.integer :book_id, null: false
      t.boolean :canceled, default: false

      t.timestamps null: false
    end

    remove_column :books, :ip
    remove_column :books, :reserved
  end
end
