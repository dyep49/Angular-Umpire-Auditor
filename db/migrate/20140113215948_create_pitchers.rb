class CreatePitchers < ActiveRecord::Migration
  def change
    create_table :pitchers do |t|
    	t.string :name
    	t.string :team
    	t.integer :pid
      t.timestamps
    end
  end
end
