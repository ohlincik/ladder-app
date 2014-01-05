class ContactsController < ApplicationController

	before_filter :authenticate_player!

  def index
  	@ranked_contacts = Player.where.not(rank: 0)
  	@new_contacts = Player.where(rank: 0)
  end

  def show
  	@player = Player.find(params[:id])
  	matches = Match.where("challenger_id = :player_id OR challenged_player_id = :player_id", {player_id: params[:id]}).order(updated_at: :desc)
  	@match_history = MatchDecorator.decorate_collection(matches)
  end
end
