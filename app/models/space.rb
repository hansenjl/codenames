class Space < ApplicationRecord
  belongs_to :board
  belongs_to :word

  def self.assignment(k)
    where("assignment = ?", k)
  end
end
