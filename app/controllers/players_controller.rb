class PlayersController < ApplicationController

	def show
		if current_player.challenge_issued? or current_player.challenge_match_pending?
			@current_challenge = Challenge.new(current_player)
		else
			@current_challenge = Challenge.new(current_player)
			@players = Player.where("rank > ?", current_player.rank-3).limit(3)
		end
	end

	def index
		@players = Player.all
	end

end