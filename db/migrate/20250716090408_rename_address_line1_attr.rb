class RenameAddressLine1Attr < ActiveRecord::Migration[8.0]
  def change
    rename_column :employees, :address_line1, :address
  end
end
