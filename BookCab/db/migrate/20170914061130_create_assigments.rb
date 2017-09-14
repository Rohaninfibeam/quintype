class CreateAssigments < ActiveRecord::Migration[5.1]
  def change
    create_table :assigments do |t|
      t.integer :cab_id
      t.integer :user_id
      t.decimal :source_lat
      t.decimal :source_long
      t.decimal :dest_long
      t.decimal :dest_lat
      t.datetime :start_time
      t.datetime :end_time
      t.datetime :assigned_time
      t.datetime :cancelled_time
      t.decimal :price

      t.timestamps
    end
  end
end
