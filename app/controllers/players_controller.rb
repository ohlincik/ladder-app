class PlayersController < ApplicationController

	def show
		if current_player.challenge_issued? or current_player.challenge_match_pending?
			@current_challenge = Challenge.new(current_player)
		else
			@current_challenge = Challenge.new(current_player)
			@players = Player.within_challenge_range(current_player)
		end
	end

	def index
		@players = Player.all
	end

end