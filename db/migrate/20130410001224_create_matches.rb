class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.belongs_to :challenger, :class_name => "Player"
      t.belongs_to :challenged, :class_name => "Player"
      t.datetime :scheduled_for
      t.datetime :played_at
      t.integer :challenger_set1
      t.integer :challenged_set1
      t.integer :challenger_set2
      t.integer :challenged_set2
      t.integer :challenger_set3
      t.integer :challenged_set3
      t.integer :winner

      t.timestamps
    end
    add_index :matches, :challenger_id
    add_index :matches, :challenged_id
  end
end
