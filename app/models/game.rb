class Game < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :num_of_players, presence: true
  has_one :board
  has_many :spaces, through: :board
  has_many :teams
  has_many :users, through: :teams
  belongs_to :creator, :class_name => 'User', :foreign_key => 'creator_id'
end
