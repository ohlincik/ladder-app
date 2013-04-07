class AddRankToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :rank, :integer, :default => 0
  end
end
