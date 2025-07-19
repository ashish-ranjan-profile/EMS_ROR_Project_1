class RemoveAddressLine2FromEmployees < ActiveRecord::Migration[8.0]
  def change
    remove_column :employees, :address_line2, :string
  end
end
