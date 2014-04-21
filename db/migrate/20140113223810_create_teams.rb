class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :abbreviation
      t.string :city
      t.string :name
      t.string :league
      t.timestamps
    end
  end
end
