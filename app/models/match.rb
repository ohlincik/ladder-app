class Match < ActiveRecord::Base
	# challenger - a player that issues the challenge
	belongs_to :challenger, class_name: 'Player'
	# challenged_player - a player receiving the challenge
	belongs_to :challenged_player, class_name: 'Player'

	cattr_accessor :alert, :score

  attr_accessible :challenged_player_id, :challenger_id,
  	:challenged_player_game1, :challenged_player_game2, :challenged_player_game3,
  	:challenger_game1, :challenger_game2, :challenger_game3,
  	:played_at, :scheduled_for, :winner

  def score_valid?

		if (challenger_game1.to_i == 15) && (challenged_player_game1.to_i < 15)
			self.score = 10
		elsif (challenger_game1.to_i < 15) && (challenged_player_game1.to_i == 15)
			self.score = 1
		else
			self.alert = "Please correct the score for GAME 1."
			return false
		end

		if (challenger_game2.to_i == 15) && (challenged_player_game2.to_i < 15)
			self.score += 10
		elsif (challenger_game2.to_i < 15) && (challenged_player_game2.to_i == 15)
			self.score += 1
		else
			self.alert = "Please correct the score for GAME 2."
			return false
		end

		if score == 11
			if (challenger_game3.to_i == 15) && (challenged_player_game3.to_i < 15)
				self.score += 10
			elsif (challenger_game3.to_i < 15) && (challenged_player_game3.to_i == 15)
				self.score += 1
			else
				self.alert = "Please correct the score for GAME 3."
				return false
			end
		end
  	return true
  end

  def declare_winner current_player
  	if self.score >= 20
			self.winner = challenger_id
			if current_player.id == winner
				notice = "CONGRATS! You won the challenge match. Your new rank is #{challenged_player.rank}"
			else
				notice = "The challenger #{challenger.first_name} #{challenger.last_name} won the match. Your new rank is #{challenged_player.rank.to_i + 1}"
			end
		else
			self.winner = challenged_player_id
			if current_player.id == winner
				notice = "CONGRATS! You won the challnge match. Your rank is safe (for now... ;-)"
			else
				notice = "The challenged player #{challenged_player.first_name} #{challenged_player.last_name} won the match. Your rank has not changed."
			end
		end
  	return notice
  end

  def challenger_victorious?
  	self.winner == self.challenger_id
  end
end
