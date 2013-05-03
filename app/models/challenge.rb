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
			"#{@player.challenges.last.challenged_player.first_name} #{@player.challenges.last.challenged_player.last_name}"
		else
			"#{@player.challenge_matches.last.challenger.first_name} #{@player.challenge_matches.last.challenger.last_name}"
		end			
	end

	def issued_on
		if self.challenge?
			@player.challenges.last.created_at
		else
			@player.challenge_matches.last.created_at
		end
	end

	def contact_email
		if self.challenge?
			@player.challenges.last.challenged_player.email
		else
			@player.challenge_matches.last.challenger.email
		end
	end

	def contact_phone
		if self.challenge?
			@player.challenges.last.challenged_player.phone
		else
			@player.challenge_matches.last.challenger.phone
		end
	end

end