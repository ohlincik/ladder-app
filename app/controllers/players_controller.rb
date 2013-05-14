class PlayersController < ApplicationController

	before_filter :authenticate_player!

	def show
		if current_player.new_player?
			@current_challenge = Challenge.new(current_player)
			@players = Player.active_ladder
			render "show_new_player"
		elsif current_player.challenge_issued? or current_player.challenge_match_pending?
			@current_challenge = Challenge.new(current_player)
		else
			@current_challenge = Challenge.new(current_player)
			@players = Player.within_challenge_range(current_player)
		end
	end

	def index
		@players = Player.active_ladder
		@new_players = Player.new_players
	end

end