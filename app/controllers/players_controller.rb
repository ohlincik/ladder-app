class PlayersController < ApplicationController

	def show
		@players = Player.where("rank > ?", current_player.rank-3).limit(3)

		# Check if the current player has issued any challenges
		if !current_player.challenges.empty?
			# Determine if the current player has issued a current challenge
			if current_player.challenges.last.played_at.nil?
				# Current challenge issued
				@current_challenge = true
				# Get the ID of the current challenge match
				@current_challenge_id = current_player.challenges.last.id
				# Get the ID of the currently challenged player
				@challenged_player_id = current_player.challenges.last.challenged_player_id
				# Get the date of the currently scheduled challenge match
				@current_challenge_date = current_player.challenges.last.scheduled_for.to_date
			end
		end
	end

end