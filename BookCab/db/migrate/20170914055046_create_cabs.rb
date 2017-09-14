class CreateCabs < ActiveRecord::Migration[5.1]
  def change
    create_table :cabs do |t|
      t.string :type
      t.string :name
      t.decimal :current_latitude
      t.decimal :current_longitude

      t.timestamps
    end
  end
end
