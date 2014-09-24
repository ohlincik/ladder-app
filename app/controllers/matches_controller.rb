class MatchesController < ApplicationController

  before_filter :authenticate_player!

  def new
    @challenger = current_player
    @challenged_player = Player.find(params[:id])
    @match = Match.new
    @match.challenger_id = @challenger.id
    @match.challenged_player_id = @challenged_player.id
    @match.challenger_game1 = @match.challenger_game2 = @match.challenger_game3 = 0
    @match.challenged_player_game1 = @match.challenged_player_game2 = @match.challenged_player_game3 = 0
  end

  def create
    match = Match.new(match_params)
    match.challenger_start_rank = match.challenger.rank
    match.challenged_player_start_rank = match.challenged_player.rank
    if match.save
      activity = Activity.new
      activity.challenge_issued match
      activity.save
      flash.notice = "Challenge successfully submitted."
      PlayerMailer.challenge_email(current_player, match.challenged_player, params[:message], params[:include_scheduling_info]).deliver
      redirect_to player_path(current_player)
    else
      flash.alert = "Could not schedule the match."
      redirect_to dashboard_path
    end
  end

  def edit
    @match = Match.find(params[:id])
    @match.played_at = Date.current.to_s(:db)
  end

  def update
    @match = Match.find(params[:id])

    @match.attributes = match_params

    if @match.score_valid?
      flash.notice = @match.declare_winner(current_player)

      if @match.challenger_victorious?
        Player.adjust_ranks(@match.challenger, @match.challenged_player)
      elsif @match.initial_challenges_complete?
        @match.challenger.add_to_bottom_of_ladder
      end

      @match.challenger_end_rank = @match.challenger.rank
      @match.challenged_player_end_rank = @match.challenged_player.rank
      
      if @match.save
        activity = Activity.new
        activity.challenge_completed @match
        activity.save
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

  def destroy
    match = Match.find(params[:id])
    match.cancel
    flash.notice = "Challenge successfully canceled."
    redirect_to player_path(current_player)
  end

private

  def match_params
    params.require(:match).permit(:challenged_player_id, :challenger_id,
    :challenged_player_game1, :challenged_player_game2, :challenged_player_game3,
    :challenger_game1, :challenger_game2, :challenger_game3,
    :played_at, :scheduled_for, :winner)
  end

end