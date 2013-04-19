class Challenge
	def initialize player
		@player = player
	end

	def challenge?
		@player.challenge_issued?
	end

	def challenge_pending?
		@player.challenge_match_pending?
	end

	def id
		self.challenge? ? @player.challenges.last.id : @player.challenge_matches.last.id
	end

	def challenged_player_name
		"#{@player.challenges.last.challenged_player.first_name} #{@player.challenges.last.challenged_player.last_name}"
	end

	def challenger_name
		"#{@player.challenge_matches.last.challenger.first_name} #{@player.challenge_matches.last.challenger.last_name}"
	end

	def date
		self.challenge? ? @player.challenges.last.scheduled_for.to_date : @player.challenge_matches.last.scheduled_for.to_date
	end
end