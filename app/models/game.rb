class Game < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :num_of_players, presence: true
  has_one :board
  has_many :spaces, through: :board
  has_many :words, through: :spaces
  has_many :teams, dependent: :destroy
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
    self.creator.team = self.teams.build(color: "red", size: team1, cards_left: board.spaces.assignment("red").count, cards_guessed: 0)
    self.creator.save
    self.teams.build(color: "blue", size: team2, cards_left: board.spaces.assignment("blue").count , cards_guessed: 0).save
    self.save
    self
  end

  def open_slots
    self.teams.map do |t|
      t.users.length
    end.reduce(:+)
  end

  def bystander_spaces
    self.spaces.assignment("bystander")
  end

  def death_space
    self.spaces.assignment("death").last
  end



  def join_team(user)
    t1 = self.teams[0]
    t2 = self.teams[1]
    t1_slots = t1.size - t1.users.length
    t2_slots = t2.size - t2.users.length
    if  t1.users.length == 0
      t1.users << user
      t1.save
    elsif t1_slots > t2_slots
      t1.users << user
      t1.save
    else
      t2.users << user
      t2.save
    end
    user
  end

  def leave_team(user)
    #this method doesn't really seem to belong in the game model
    user.team = nil
    user.save #this will also change team.users array
  end

  def start
    #set the 'leaders' for each team
    self.teams.each do |t|
      t.leader = t.users.sample
      t.save
    end

  end
end

