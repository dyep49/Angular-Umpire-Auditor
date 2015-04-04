class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
    	t.integer :user_id
    	t.integer :team_id
    	t.integer :pitcher_id
    	t.integer :umpire_id
    	t.integer :user_id
      t.timestamps
    end
  end
end
