class AddPlayToPitch < ActiveRecord::Migration
  def change
    add_column :pitches, :play, :string
  end
end
