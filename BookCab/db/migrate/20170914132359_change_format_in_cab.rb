class ChangeFormatInCab < ActiveRecord::Migration[5.1]
  def change
  	change_column :cabs, :current_latitude, :float
  	change_column :cabs, :current_longitude, :float
  end
end
