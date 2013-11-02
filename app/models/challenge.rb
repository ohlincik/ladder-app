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

	def player_first_name
		if self.challenge?
			@player.challenges.last.challenged_player.first_name
		else
			@player.challenge_matches.last.challenger.first_name
		end		
	end

	def player_full_name
		if self.challenge?
			@player.last_challenge.challenged_player.name
		else
			@player.last_challenge.challenger.name
		end			
	end

	def issued_on
		@player.last_challenge.created_at
	end

	def contact_email
		if self.challenge?
			@player.last_challenge.challenged_player.email
		else
			@player.last_challenge.challenger.email
		end
	end

	def contact_phone
		if self.challenge?
			@player.last_challenge.challenged_player.phone
		else
			@player.last_challenge.challenger.phone
		end
	end

	def scheduling_info
		if self.challenge?
			@player.last_challenge.challenged_player.scheduling_info
		else
			@player.last_challenge.challenger.scheduling_info
		end
	end

end