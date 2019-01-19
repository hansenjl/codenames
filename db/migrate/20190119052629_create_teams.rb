class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :color
      t.belongs_to :game
      t.integer :cards_left
      t.integer :cards_guessed
      t.timestamps
    end
  end
end
