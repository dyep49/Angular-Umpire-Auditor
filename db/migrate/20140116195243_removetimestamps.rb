class Removetimestamps < ActiveRecord::Migration
  def up
  	remove_column :teams, :created_at
  	remove_column :teams, :updated_at
  	remove_column :games, :created_at
  	remove_column :games, :updated_at
  end

  def down
  	add_column :teams, :created_at
  	add_column :teams, :updated_at
  	add_column :games, :created_at
  	add_column :games, :updated_at
  end
end
