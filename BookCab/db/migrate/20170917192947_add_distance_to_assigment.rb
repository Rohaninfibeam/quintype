class AddDistanceToAssigment < ActiveRecord::Migration[5.1]
  def change
    add_column :assigments, :distance, :float
  end
end
