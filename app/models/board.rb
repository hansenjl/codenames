class Board < ApplicationRecord
  belongs_to :game
  has_many :spaces
  has_many :words, through: :spaces
17
  def self.generate(game)

    configuration_array = ["red","red","red","red", "red","red", "red","red", game.starter, "blue","blue","blue","blue", "blue","blue","blue","blue", "death", "bystander", "bystander", "bystander", "bystander", "bystander", "bystander", "bystander" ].shuffle
    configuration = configuration_array.join(", ")
    board = game.build_board(configuration: configuration)
    board.set_spaces(configuration_array)
    board.save
    board
  end

  def set_spaces(configuration)
    words = Word.all.shuffle
    configuration.each_with_index do |c, index|
      self.spaces.build(assignment: c, word_id: words[index].id).save
    end
  end
end
