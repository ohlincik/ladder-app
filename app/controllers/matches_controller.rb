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
		@match_set = (0..15).to_a
	end

	def update
		@match = Match.find(params[:id])

		if @match.update_attributes(params[:match])
			flash.notice = "Challenge match was updated."
			redirect_to player_path(current_player)
		else
			render :action => "edit"
		end
	end

end