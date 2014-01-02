class PlayersController < ApplicationController

	before_filter :authenticate_player!

	def show
		if Player.no_ranked_players?
			@show_onboarding_message = true
			render "show_new_player"
		else
			@latest_activity = Match.order(updated_at: :desc).limit(5)
			if current_player.new_player?
				@current_challenge = Challenge.new(current_player)
				@players = Player.active_ladder
				@show_onboarding_message = false
				render "show_new_player"
			elsif current_player.challenge_issued? or current_player.challenge_match_pending?
				@current_challenge = Challenge.new(current_player)
			else
				@current_challenge = Challenge.new(current_player)
				@players = Player.within_challenge_range(current_player)
			end
		end
	end

	def index
		if Player.no_ranked_players?
			@show_onboarding_message = true
			@new_players = Player.new_players
		else
			@show_onboarding_message = false
			@players = Player.active_ladder
			@new_players = Player.new_players
		end
	end

private

	def player_params
		params.require(:player).permit(:rank, :first_name, :last_name, :phone, :email, :password, :password_confirmation, :remember_me)
	end

end