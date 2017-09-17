class AddCurrentLatToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :current_lat, :decimal
  end
end
