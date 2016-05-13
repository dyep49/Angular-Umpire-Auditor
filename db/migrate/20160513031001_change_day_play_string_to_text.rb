class ChangeDayPlayStringToText < ActiveRecord::Migration
  def change
    change_column(:days, :play, :text)
  end
end
