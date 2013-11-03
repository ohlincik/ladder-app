class ChangePlayedAtToDate < ActiveRecord::Migration
  def up
  	change_column :matches, :played_at, :date
  end

  def down
  	change_column :matches, :played_at, :datetime
  end
end
