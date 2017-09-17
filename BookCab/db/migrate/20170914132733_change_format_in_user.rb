class ChangeFormatInUser < ActiveRecord::Migration[5.1]
  def change
  	change_column :users, :current_lat, :float
  	change_column :users, :current_long, :float
  end
end
