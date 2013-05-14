class AddConfirmableToPlayers < ActiveRecord::Migration
  # Note: You can't use change, as Player.update_all with fail in the down migration
  def up
    add_column :players, :confirmation_token, :string
    add_column :players, :confirmed_at, :datetime
    add_column :players, :confirmation_sent_at, :datetime
    # add_column :players, :unconfirmed_email, :string # Only if using reconfirmable
    add_index :players, :confirmation_token, :unique => true
    # Player.reset_column_information # Need for some types of updates, but not for update_all.
    # To avoid a short time window between running the migration and updating all existing
    # players as confirmed, do the following
    Player.update_all(:confirmed_at => Time.now)
    # All existing user accounts should be able to log in after this.
  end

  def down
    remove_column :players, :confirmation_token, :confirmed_at, :confirmation_sent_at
    # remove_column :players, :unconfirmed_email # Only if using reconfirmable
  end
end
