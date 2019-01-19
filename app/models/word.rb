class Word < ApplicationRecord
  validates_uniqueness_of :text, :case_sensitive => false
  has_many :spaces

end
