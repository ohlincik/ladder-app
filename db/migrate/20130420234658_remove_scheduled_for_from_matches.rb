class RemoveScheduledForFromMatches < ActiveRecord::Migration
  def up
  	remove_column :matches, :scheduled_for
  end

  def down
  	add_column :matches, :scheuled_for, :datetime
  end
end
