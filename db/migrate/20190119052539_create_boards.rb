class CreateBoards < ActiveRecord::Migration[5.2]
  def change
    create_table :boards do |t|
      t.belongs_to :game
      t.string :configuration
      t.timestamps
    end
  end
end
