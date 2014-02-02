class CreateActivities < ActiveRecord::Migration
  def up
    create_table :activities do |t|
      t.date :activity_date
      t.string :activity_type
      t.integer :challenger_id
      t.string :challenger_first_name
      t.string :challenger_last_name
      t.integer :challenger_start_rank
      t.integer :challenger_end_rank
      t.integer :challenged_player_id
      t.string :challenged_player_first_name
      t.string :challenged_player_last_name
      t.integer :challenged_player_start_rank
      t.integer :challenged_player_end_rank
      t.integer :winner
      t.string :score
    end

    add_index :activities, :challenger_id, name: "index_activities_on_challenger_id", using: :btree
    add_index :activities, :challenged_player_id, name: "index_activities_on_challenged_player_id", using: :btree

  end
end
