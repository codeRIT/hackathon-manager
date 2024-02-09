class SchoolNameDuplicate < ApplicationRecord
  validates_uniqueness_of :name, case_sensitive: false

  strip_attributes

  belongs_to :school
end
