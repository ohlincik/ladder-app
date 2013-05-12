class MatchesController < ApplicationController

	def new
		@challenger = current_player
		@challenged_player = Player.find(params[:id])
		@match = Match.new
		@match.challenger_id = @challenger.id
		@match.challenged_player_id = @challenged_player.id
	end

	def create
		match = Match.new(params[:match])
		if match.save
			flash.notice = "Challenge successfully submitted."
			PlayerMailer.challenge_email(current_player, match.challenged_player, params[:message]).deliver
			redirect_to player_path(current_player)
		else
			flash.alert = "Could not schedule the match."
			redirect_to dashboard_path
		end
	end

	def edit
		@match = Match.find(params[:id])
		@match.played_at = Date.current
	end

	def update
		@match = Match.find(params[:id])

		@match.attributes = params[:match]

		if @match.played_at_valid? and @match.score_valid?
			flash.notice = @match.declare_winner(current_player)
			if @match.save
				if @match.challenger_victorious?
					Player.adjust_ranks(@match.challenger, @match.challenged_player)
				elsif @match.initial_challenges_complete?
					@match.challenger.add_to_bottom_of_ladder
				end
				if current_player == @match.challenger
					PlayerMailer.challenge_completed_by_challenger_email(@match).deliver
				else
					PlayerMailer.challenge_completed_by_challenged_player_email(@match).deliver
				end
				redirect_to player_path(current_player)
			else
				render :action => "edit"
			end
		else
			flash.alert = @match.alert
			render :action => "edit"
		end
	end

end