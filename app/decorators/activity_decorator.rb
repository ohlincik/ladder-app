class ActivityDecorator < Draper::Decorator
  delegate_all

  def challenge_completed?
    activity_type == "Challenge Completed"
  end

  def challenge_issued?
    activity_type == "Challenge Issued"
  end

  def rank_changed?
    challenger_victorious?
  end

  def challenger_name
    "#{challenger_first_name} #{challenger_last_name}"
  end

  def challenged_player_name
    "#{challenged_player_first_name} #{challenged_player_last_name}"
  end

  def winner_name
    if challenger_victorious?
      challenger_name
    else
      challenged_player_name
    end
  end

  def loser_name
    if challenger_victorious?
      challenged_player_name
    else
      challenger_name
    end
  end

  def challenge_completed_at
    activity_date.to_s(:mini)
  end

  def challenge_issued_at
    activity_date.to_s(:mini)
  end

  def challenge_canceled_at
    activity_date.to_s(:mini)
  end

  def match_score
    score
  end

end
