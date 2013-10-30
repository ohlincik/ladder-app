class ContactsController < ApplicationController

	before_filter :authenticate_player!

  def index
  	@ranked_contacts = Player.where.not(rank: 0)
  	@new_contacts = Player.where(rank: 0)
  end

  def show
  	@contact = Player.find(params[:id])
  end
end
