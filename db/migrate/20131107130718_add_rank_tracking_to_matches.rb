class AddRankTrackingToMatches < ActiveRecord::Migration
  def change
  	add_column :matches, :challenger_start_rank, :integer
  	add_column :matches, :challenger_end_rank, :integer
  	add_column :matches, :challenged_player_start_rank, :integer
  	add_column :matches, :challenged_player_end_rank, :integer
  end
end
