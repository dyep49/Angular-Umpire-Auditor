class Addteamidcolumn < ActiveRecord::Migration
  def up
  	drop_table :teams
  	create_table :teams do |t|
		t.integer :team_id
		t.string :abbreviation
		t.string :full_name
		t.integer :division_id
		t.integer :league_id
		t.string :code
		t.string :city
		t.string :name_brief
	end
  end

  def down 
  end
end




