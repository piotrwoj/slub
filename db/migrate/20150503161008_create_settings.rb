class CreateSettings < ActiveRecord::Migration
  def up
    create_table :settings do |t|
    	t.string :name, null: false
    	t.text :value
    	t.timestamps null: false
    end
  end

  def down
  	drop_table :settings
  end
end
