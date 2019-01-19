class AddSizeToTeams < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :size, :integer
  end
end
