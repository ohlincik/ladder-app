class AddContactOptionsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :show_contact_info, :boolean, default: true
    add_column :players, :scheduling_info, :text
  end
end
