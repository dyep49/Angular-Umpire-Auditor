class AddImgDateToDay < ActiveRecord::Migration
  def change
    add_column :days, :img_date, :string
  end
end
