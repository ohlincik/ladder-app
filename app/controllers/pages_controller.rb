class PagesController < ApplicationController

	def home
		if player_signed_in?
			redirect_to player_path(current_player)
		end
	end

	def rules
	end

end