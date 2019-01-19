class CreateSpaces < ActiveRecord::Migration[5.2]
  def change
    create_table :spaces do |t|
      t.belongs_to :word
      t.belongs_to :board
      t.boolean :revealed, default: false
      t.string :assignment

      t.timestamps
    end
  end
end
