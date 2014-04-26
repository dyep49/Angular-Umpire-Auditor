class AddUmpireidToDay < ActiveRecord::Migration
  def change
    add_column :days, :umpire_id, :integer
  end
end
