class AddStarterToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :starter, :string
  end
end
