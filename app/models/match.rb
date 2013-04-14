class Match < ActiveRecord::Base
	# challenger - a player that issues the challenge
	belongs_to :challenger, class_name: 'Player'
	# challenged_player - a player receiving the challenge
	belongs_to :challenged_player, class_name: 'Player'

  attr_accessible :challenged_player_id, :challenged_player_set1, :challenged_player_set2, :challenged_player_set3, :challenger_id, :challenger_set1, :challenger_set2, :challenger_set3, :played_at, :scheduled_for, :winner
end
