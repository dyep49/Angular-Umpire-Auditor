class Adddatetopitch < ActiveRecord::Migration
  def up
  	add_column :pitches, :date_string, :string
  end

  def down
  	remove_column :pitches, :date_string
  end
end
