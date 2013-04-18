class Match < ActiveRecord::Base
	# challenger - a player that issues the challenge
	belongs_to :challenger, class_name: 'Player'
	# challenged_player - a player receiving the challenge
	belongs_to :challenged_player, class_name: 'Player'

  attr_accessible :challenged_player_id, :challenger_id,
  	:challenged_player_game1, :challenged_player_game2, :challenged_player_game3,
  	:challenger_game1, :challenger_game2, :challenger_game3,
  	:played_at, :scheduled_for, :winner
end
