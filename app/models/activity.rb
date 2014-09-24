class Activity < ActiveRecord::Base

  default_scope { order(activity_date: :desc) }
  scope :player_activity, ->(player_id) { where("challenger_id = ? OR challenged_player_id = ?", player_id, player_id) }

  def challenger_victorious?
    challenger_id == winner
  end

  def challenge_issued match
    self.activity_date = match.created_at
    self.activity_type = "Challenge Issued"
    self.challenger_id = match.challenger_id
    self.challenger_first_name = match.challenger.first_name
    self.challenger_last_name = match.challenger.last_name
    self.challenger_start_rank = match.challenger_start_rank
    self.challenged_player_id = match.challenged_player_id
    self.challenged_player_first_name = match.challenged_player.first_name
    self.challenged_player_last_name = match.challenged_player.last_name
    self.challenged_player_start_rank = match.challenged_player_start_rank
  end

  def challenge_canceled match
    self.activity_date = Date.today
    self.activity_type = "Challenge Canceled"
    self.challenger_id = match.challenger_id
    self.challenger_first_name = match.challenger.first_name
    self.challenger_last_name = match.challenger.last_name
    self.challenger_start_rank = match.challenger_start_rank
    self.challenged_player_id = match.challenged_player_id
    self.challenged_player_first_name = match.challenged_player.first_name
    self.challenged_player_last_name = match.challenged_player.last_name
    self.challenged_player_start_rank = match.challenged_player_start_rank
  end

  def challenge_completed match
    self.activity_date = match.played_at
    self.activity_type = "Challenge Completed"
    self.challenger_id = match.challenger_id
    self.challenger_first_name = match.challenger.first_name
    self.challenger_last_name = match.challenger.last_name
    self.challenger_start_rank = match.challenger_start_rank
    self.challenger_end_rank = match.challenger_end_rank
    self.challenged_player_id = match.challenged_player_id
    self.challenged_player_first_name = match.challenged_player.first_name
    self.challenged_player_last_name = match.challenged_player.last_name
    self.challenged_player_start_rank = match.challenged_player_start_rank
    self.challenged_player_end_rank = match.challenged_player_end_rank
    self.winner = match.winner

    if match.challenger_victorious?
      score = "#{match.challenger_game1}:#{match.challenged_player_game1}, #{match.challenger_game2}:#{match.challenged_player_game2}"
      if match.challenger_game3 != 0 or match.challenged_player_game3 != 0
        score = score + ", #{match.challenger_game3}:#{match.challenged_player_game3}"
      end
    else
      score = "#{match.challenged_player_game1}:#{match.challenger_game1}, #{match.challenged_player_game2}:#{match.challenger_game2}"
      if match.challenger_game3 != 0 or match.challenged_player_game3 != 0
        score = score + ", #{match.challenged_player_game3}:#{match.challenger_game3}"
      end
    end
    self.score = score
  end

end