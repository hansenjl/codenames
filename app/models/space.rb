class Space < ApplicationRecord
  belongs_to :board
  belongs_to :word

  def self.red
    where(assignment: "red")
  end

  def self.blue
    where(assignment: "blue")
  end
end
