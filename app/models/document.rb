class Document < ApplicationRecord
DOC_TYPES = [ "Marksheet", "Foto id", "Address proof", "Others" ].freeze

 belongs_to :employee, foreign_key: :employee_id
  has_one_attached :file

  validates :file, presence: true
 validates :name, :doc_type, :employee_id, presence: true
end
