class CreateUmpires < ActiveRecord::Migration
  def change
    create_table :umpires do |t|
      t.string :name
      t.integer :mlb_umpire_id
    end
    add_index :umpires, :mlb_umpire_id, :unique => true, :name => 'my_index'
  end
end
