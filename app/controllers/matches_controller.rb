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

		# Update the match attributes with the data from edit form
		@match.attributes = params[:match]

		### Determine if the score was input properly

		# Check game 1
		if (@match.challenger_game1.to_i == 15) && (@match.challenged_player_game1.to_i < 15)
			# GOOD - Challenger won the game
			score = 10

		elsif (@match.challenger_game1.to_i < 15) && (@match.challenged_player_game1.to_i == 15)
			# GOOD - Challenged player won the game
			score = 1

		else
			# BAD - the score is incorrect
			flash.alert = "Please correct the score for GAME 1."
			render :action => "edit" and return
		end

		# Check game 2
		if (@match.challenger_game2.to_i == 15) && (@match.challenged_player_game2.to_i < 15)
			# GOOD - Challenger won the game
			score = score + 10

		elsif (@match.challenger_game2.to_i < 15) && (@match.challenged_player_game2.to_i == 15)
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
			if (@match.challenger_game3.to_i == 15) && (@match.challenged_player_game3.to_i < 15)
				# GOOD - Challenger won the game and match
				@match.winner = @match.challenger_id

				if current_player.id == @match.winner
					flash.notice = "CONGRATS! You won the challenge match. Your new rank is #{@match.challenged_player.rank}"
					#------ Player.adjust_ranks(current_player, @match.challenged_player)
				else
					flash.notice = "The challenger #{@match.challenger.first_name} #{@match.challenger.last_name} won the match. Your new rank is #{@match.challenged_player.rank.to_i + 1}"
				end
			elsif (@match.challenger_game3.to_i < 15) && (@match.challenged_player_game3.to_i == 15)
				# GOOD - Challenged player won the game and match
				# Challenged player won the match
				@match.winner = @match.challenged_player_id

				if current_player.id == @match.winner
					flash.notice = "CONGRATS! You won the challnge match. Your rank is safe (for now... ;-)"
				else
					flash.notice = "The challenged player #{@match.challenged_player.first_name} #{@match.challenged_player.last_name} won the match. Your rank has not changed."
				end
			else
				# BAD - the score is incorrect
				flash.alert = "Please correct the score for GAME 3."
				render :action => "edit" and return
			end
		else
			if score == 20
				# Challenger won the match
				@match.winner = @match.challenger_id

				if current_player.id == @match.winner
					flash.notice = "CONGRATS! You won the challenge match. Your new rank is #{@match.challenged_player.rank}"
					#----- Player.adjust_ranks(current_player, @match.challenged_player)
				else
					flash.notice = "The challenger #{@match.challenger.first_name} #{@match.challenger.last_name} won the match. Your new rank is #{@match.challenged_player.rank.to_i + 1}"
				end
				
			else
				# Challenged player won the match
				@match.winner = @match.challenged_player_id

				if current_player.id == @match.winner
					flash.notice = "CONGRATS! You won the challnge match. Your rank is safe (for now... ;-)"
				else
					flash.notice = "The challenged player #{@match.challenged_player.first_name} #{@match.challenged_player.last_name} won the match. Your rank has not changed."
				end
			end
		end

		#if @match.update_attributes(params[:match])
			render :action => "edit"
			#redirect_to player_path(current_player)
		#else
		#	render :action => "edit"
		#end
	end

end