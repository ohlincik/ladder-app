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
		@match_score = (0..15).to_a
	end

	def update
		@match = Match.find(params[:id])
		@match_score = (0..15).to_a

		# Determine if the score was input properly
		challenger_game1 = params[:challenger_game1]
		challenger_game2 = params[:challenger_game2]
		challenger_game3 = params[:challenger_game3]
		challenged_player_game1 = params[:challenged_player_game1]
		challenged_player_game2 = params[:challenged_player_game2]
		challenged_player_game3 = params[:challenged_player_game3]

		# Check game 1
		if (challenger_game1.to_i == 15) && (challenged_player_game1.to_i < 15)
			# GOOD - Challenger won the game
			score = 10

		elsif (challenger_game1.to_i < 15) && (challenged_player_game1.to_i == 15)
			# GOOD - Challenged player won the game
			score = 1

		else
			# BAD - the score is incorrect
			flash.alert = "Please correct the score for GAME 1."
			render :action => "edit" and return
		end

		# Check game 2
		if (challenger_game2.to_i == 15) && (challenged_player_game2.to_i < 15)
			# GOOD - Challenger won the game
			score = score + 10

		elsif (challenger_game2.to_i < 15) && (challenged_player_game2.to_i == 15)
			# GOOD - Challenged player won the game
			score = score + 1

		else
			# BAD - the score is incorrect
			flash.alert = "Please correct the score for GAME 2."
			render :action => "edit" and return
		end

		# Check if game 3 was necessary
		if score == 11
			# Match tied, need game 3 to decide
			if (challenger_game3.to_i == 15) && (challenged_player_game3.to_i < 15)
				# GOOD - Challenger won the game and match
				
			elsif (challenger_game3.to_i < 15) && (challenged_player_game3.to_i == 15)
				# GOOD - Challenged player won the game and match
				
			else
				# BAD - the score is incorrect
				flash.alert = "Please correct the score for GAME 3."
				render :action => "edit" and return
			end
		else
			if score == 20
				# Challenger won the match
				flash.notice = "The challenger #{@match.challenger.first_name} #{@match.challenger.last_name} won."
			else
				# Challenged player won the match
				flash.notice = "The challenged player #{@match.challenged_player.first_name} #{@match.challenged_player.last_name} won."
			end
		end

		#if @match.update_attributes(params[:match])
			redirect_to player_path(current_player)
		#else
		#	render :action => "edit"
		#end
	end

end