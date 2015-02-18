class AddDefaultToGames < ActiveRecord::Migration
  def change
    change_column_default :games, :finished, false
  end
end
