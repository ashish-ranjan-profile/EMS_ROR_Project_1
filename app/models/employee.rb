class Employee < ApplicationRecord
has_many :documents, dependent: :destroy
 has_one_attached :file



 validates :first_name, :last_name, presence: true
 validates :email, presence: true, uniqueness: true
 validates :city, :address, :state, presence: true

  def name
    "#{first_name} #{last_name}".strip
  end

  def full_address
    "#{address}, #{city}, #{state}, #{pincode}"
  end
end
