class Adddefaulttopitch < ActiveRecord::Migration
  def up
  	change_column :pitches, :distance_missed_x, :float, :default => 0
  	change_column :pitches, :distance_missed_y, :float, :default => 0
  	change_column :pitches, :total_distance_missed, :float, :default => 0
  end

  def down
  end
end
