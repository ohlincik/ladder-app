class RenameSetsToGames < ActiveRecord::Migration
  def up
  	rename_column :matches, :challenged_player_set1, :challenged_player_game1
  	rename_column :matches, :challenged_player_set2, :challenged_player_game2
  	rename_column :matches, :challenged_player_set3, :challenged_player_game3
  	rename_column :matches, :challenger_set1, :challenger_game1
  	rename_column :matches, :challenger_set2, :challenger_game2
  	rename_column :matches, :challenger_set3, :challenger_game3
  end

  def down
  	rename_column :matches, :challenger_game3, :challenger_set3
  	rename_column :matches, :challenger_game2, :challenger_set2
  	rename_column :matches, :challenger_game1, :challenger_set1
  	rename_column :matches, :challenged_player_game3, :challenged_player_set3
  	rename_column :matches, :challenged_player_game2, :challenged_player_set2
  	rename_column :matches, :challenged_player_game1, :challenged_player_set1
  end
end
