class PlayersController < ApplicationController

	def show
		if current_player.any_challenges? || current_player.any_challenge_matches?
			@current_challenge = Challenge.new(current_player)
		else
			@players = Player.where("rank > ?", current_player.rank-3).limit(3)
		end
	end

	def index
		@players = Player.all
	end

end