class RemoveTimestampsUmpire < ActiveRecord::Migration
  def up
  	remove_column :umpires, :created_at
  	remove_column :umpires, :updated_at
  end

  def down
  	add_column :umpires, :created_at
    add_column :umpires, :updated_at
  end
end
