class Game < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :num_of_players, presence: true
  has_one :board
  has_many :spaces, through: :board
  has_many :teams
  has_many :users, through: :teams
  belongs_to :creator, :class_name => 'User', :foreign_key => 'creator_id'

  def generate_board
    if self.num_of_players.even?
      team1 = self.num_of_players/2
      team2 = self.num_of_players/2
    else
      team1 = self.num_of_players/2 + 1
      team2 = self.num_of_players/2
    end
    self.active = true
    self.starter = ["red","blue"].sample
    board = Board.generate(self)
    self.creator.team = self.teams.build(color: "red", size: team1, cards_left: board.spaces.red.count, cards_guessed: 0)
    self.creator.save
    self.teams.build(color: "blue", size: team2, cards_left: board.spaces.blue.count , cards_guessed: 0).save
    self.save
    self
  end

  def open_slots
    self.teams.map do |t|
      t.users.length
    end.reduce(:+)
  end
end

