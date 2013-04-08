class PlayersController < ApplicationController

	def show
		@player = current_player
		@players = Player.where("rank > ?", @player.rank-3).order("rank").limit(3)
	end

	def challenge
		@challenger = current_player
		@challenged = Player.find(params[:id])
	end

end