class AddPitchIdToDay < ActiveRecord::Migration
  def change
    add_column :days, :pitch_id, :integer
  end
end
