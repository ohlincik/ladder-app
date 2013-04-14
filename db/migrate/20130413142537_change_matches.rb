class ChangeMatches < ActiveRecord::Migration
  def up
  	rename_column :matches, :challenged_id, :challenged_player_id
  	rename_column :matches, :challenged_set1, :challenged_player_set1
  	rename_column :matches, :challenged_set2, :challenged_player_set2
  	rename_column :matches, :challenged_set3, :challenged_player_set3
  	rename_index :matches, :index_matches_on_challenged_id, :index_matches_on_challenged_player_id
  end

  def down
  	rename_index :matches, :index_matches_on_challenged_player_id, :index_matches_on_challenged_id
  	rename_column :matches, :challenged_player_set3, :challenged_set3
  	rename_column :matches, :challenged_player_set2, :challenged_set2
  	rename_column :matches, :challenged_player_set1, :challenged_set1
  	rename_column :matches, :challenged_player_id, :challenged_id
  end
end
