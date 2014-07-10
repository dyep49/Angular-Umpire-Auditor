class AddPitchIdToGame < ActiveRecord::Migration
  def change
    add_column :games, :pitch_id, :integer
  end
end
