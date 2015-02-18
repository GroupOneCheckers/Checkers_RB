class RemoveTurnCountFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :turn_count
  end
end
