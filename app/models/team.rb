class Team < ApplicationRecord
  belongs_to :game
  has_many :users
  belongs_to :leader,  class_name: "User", optional: true

  def self.red
    where(color: "red").last
  end

  def self.blue
    where(color: "blue").last
  end

  def spaces
    self.game.spaces.assignment(self.color)
  end

  def words
    self.spaces.collect {|s| s.word.text}
  end

  def opposite_color
    self.color == "blue" ? "red" : "blue"
  end

  def other_team
    self.game.teams.find_by_color(opposite_color)
  end

  def other_team_spaces
    self.game.spaces.assignment(self.opposite_color)
  end

  def check_guess(word)

    if !!(card = self.spaces.detect{|s| s.word.text == word})
      #correct guess
      {guess: "correct", color: self.color, card: card, turn: "continue"}
    elsif !!(card = self.other_team_spaces.detect{|s| s.word.text == word})
      #it was the other team's word
      {guess: "wrong", color:self.opposite_color, card: card, turn: "over"}
    elsif card = self.game.bystander_spaces.detect{|s|  s.word.text == word}
      {guess: "bystander", color: 'beige', card: card, turn: "over"}
    else
      #need to change this to accept an object: winner: self.other_team.id
      self.game.update(active: false, winner: self.other_team.id)
      {guess: "death", color: 'black', card: self.game.death_space, turn: "over"}
    end
  end


end
