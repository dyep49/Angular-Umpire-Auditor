class AddPlayToDay < ActiveRecord::Migration
  def change
    add_column :days, :play, :string
  end
end
