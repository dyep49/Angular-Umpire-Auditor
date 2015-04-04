class ChangePitchColumnPlayToText < ActiveRecord::Migration

  def change
    change_column :pitches, :play, :text
  end

end
