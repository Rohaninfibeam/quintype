class ChangeFormatInAssigment < ActiveRecord::Migration[5.1]
  def change
  	change_column :assigments, :source_lat, :float
  	change_column :assigments, :source_long, :float
  	change_column :assigments, :dest_lat, :float
  	change_column :assigments, :dest_long, :float
  	change_column :assigments, :price, :float
  end
end