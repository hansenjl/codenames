class AddGuesserIdToTeams < ActiveRecord::Migration[5.2]
  def change
      add_column :teams, :leader_id, :integer
  end
end
