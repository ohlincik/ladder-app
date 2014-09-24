class ContactsController < ApplicationController

	before_filter :authenticate_player!

  def index
  	@ranked_contacts = Player.where.not(rank: 0)
  	@new_contacts = Player.where(rank: 0)
  end

  def show
  	@player = Player.find(params[:id])
    @player_activity = Activity.player_activity(@player)
  	@player_activity = ActivityDecorator.decorate_collection(@player_activity)
  end
end
