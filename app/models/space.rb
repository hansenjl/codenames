class Space < ApplicationRecord
  belongs_to :board
  belongs_to :word
  belongs_to :game, through: :board
end
