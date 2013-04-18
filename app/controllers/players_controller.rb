class PlayersController < ApplicationController

	def show
		@players = Player.where("rank > ?", current_player.rank-3).limit(3)

		# Check if the current player has issued any challenges
		if !current_player.challenges.empty?
			# Determine if the current player has issued a current challenge
			if current_player.challenges.last.played_at.nil?
				# Current challenge issued
				@current_challenge_issued = true
				# Get the ID of the current challenge match
				@current_challenge_id = current_player.challenges.last.id
				# Get the ID of the currently challenged player
				@challenged_player_name = "#{current_player.challenges.last.challenged_player.first_name} #{current_player.challenges.last.challenged_player.last_name}"
				# Get the date of the currently scheduled challenge match
				@current_challenge_date = current_player.challenges.last.scheduled_for.to_date
			end
		end

		# Check if the current player has any pending challenges
		if !current_player.challenge_matches.empty?
			# Determine if the current player currently has a pending challenge
			if current_player.challenge_matches.last.played_at.nil?
				# Current challenge pending
				@current_challenge_pending = true
				# Get the ID of the pending challenge match
				@current_challenge_id = current_player.challenge_matches.last.id
				# Get the ID of the current challenger
				@challenger_name = "#{current_player.challenge_matches.last.challenger.first_name} #{current_player.challenge_matches.last.challenger.last_name}"
				# Get the date of the pending challenge match
				@current_challenge_date = current_player.challenge_matches.last.scheduled_for.to_date
			end
		end
	end

	def index
		@players = Player.all
	end

end