class AddAttributesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :wins, :integer, :default => 0
    add_column :users, :losses, :integer, :default => 0
    add_column :users, :forfeits, :integer, :default => 0
    add_column :users, :level, :integer, :default => 1
    add_column :users, :experience, :integer, :default => 0
    add_column :users, :division, :string
  end
end
