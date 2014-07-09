class AddInningsToDay < ActiveRecord::Migration
  def change
    add_column :days, :inning, :string
    add_column :days, :ball_count, :integer
    add_column :days, :strike_count, :integer
    add_column :days, :outs, :integer
    add_column :days, :inning_half, :string
  end
end
