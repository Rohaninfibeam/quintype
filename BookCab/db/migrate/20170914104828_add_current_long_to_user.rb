class AddCurrentLongToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :current_long, :decimal
  end
end
