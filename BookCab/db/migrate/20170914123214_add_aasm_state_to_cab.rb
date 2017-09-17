class AddAasmStateToCab < ActiveRecord::Migration[5.1]
  def change
    add_column :cabs, :aasm_state, :string
  end
end
