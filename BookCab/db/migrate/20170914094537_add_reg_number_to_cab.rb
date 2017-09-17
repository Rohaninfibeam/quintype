class AddRegNumberToCab < ActiveRecord::Migration[5.1]
  def change
    add_column :cabs, :reg_number, :string
  end
end
