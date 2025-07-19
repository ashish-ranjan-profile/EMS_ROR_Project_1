# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

employee = Employee.create(
first_name: 'Murli',
last_name: 'manohar',
mobile_num: '8892563415',
email: 'murlimanohar220@gmail.com',
city: 'Muzaffarpur',
pincode: '842002',
state: 'Bihar',
address_line1: 'Government appartment, Station road near oyo hotel, Muzaffarpur, 820051, Bihar'
)
employee.save
# 2nd way to create employee

employee1 = Employee.new(
  first_name: 'Asif',
last_name: 'Kumar',
mobile_num: '8892563415',
email: 'asifkumar420@gmail.com',
city: 'Muzaffarpur',
pincode: '842002',
state: 'Bihar',
address_line1: 'Government appartment, Station road near oyo hotel, Muzaffarpur, 820051, Bihar'
)
employee1.save
