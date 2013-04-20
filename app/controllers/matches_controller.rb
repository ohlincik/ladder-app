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
			flash.notice = "Challenge match successfully scheduled."
			redirect_to player_path(current_player)
		else
			flash.alert = "Could not schedule the match."
			redirect_to dashboard_path
		end
	end

	def edit
		@match = Match.find(params[:id])
		@match.played_at = @match.scheduled_for
		@match_score = (0..15).to_a
	end

	def update
		@match = Match.find(params[:id])
		@match_score = (0..15).to_a

		@match.attributes = params[:match]

		if @match.score_valid?
			flash.notice = @match.declare_winner(current_player)
			if @match.challenger_victorious?
				current_player.adjust_ranks(@match.challenged_player)
			end
			@match.save
			redirect_to player_path(current_player)
		else
			flash.alert = @match.alert
			render :action => "edit"
		end
	end

end