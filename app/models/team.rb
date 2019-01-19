class Team < ApplicationRecord
  belongs_to :game
  has_many :users

  def self.red
    where(color: "red").last
  end

  def self.blue
    where(color: "blue").last
  end

end
