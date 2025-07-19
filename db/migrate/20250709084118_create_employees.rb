class CreateEmployees < ActiveRecord::Migration[8.0]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :mobile_num
      t.string :city
      t.string :state
      t.string :pincode
      t.string :address_line1
      t.string :address_line2

      t.timestamps
    end
  end
end
