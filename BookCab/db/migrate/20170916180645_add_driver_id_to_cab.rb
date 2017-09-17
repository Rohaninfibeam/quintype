class AddDriverIdToCab < ActiveRecord::Migration[5.1]
  def change
    add_column :cabs, :driver_id, :integer
  end
end
