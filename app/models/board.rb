class Board < ApplicationRecord
  belongs_to :game
  has_many :spaces
  has_many :words, through: :spaces

  #this has the
end
