class AddIpToBooks < ActiveRecord::Migration
  def up
  	add_column :books, :ip, :string
  end

  def down
  	remove_column :books, :ip
  end
end
