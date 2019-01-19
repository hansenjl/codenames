class AddNameToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :name, :string
    add_column :games, :active, :boolean
    add_column :games, :winner, :string
  end
end
