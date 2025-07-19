class AddColumnsToEmployees < ActiveRecord::Migration[8.0]
  def change
    add_column :employees, :DOB, :date
    add_column :employees, :job_title, :string
  end
end
