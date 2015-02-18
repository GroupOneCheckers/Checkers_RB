class AddAtrributesToGame < ActiveRecord::Migration
  def change
    create_table(:games) do |t|
    t.integer :players_count
    t.integer :winner_id
    t.integer :turn_count, default: 0
    end
  end
end
