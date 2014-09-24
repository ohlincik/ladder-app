class Player < ActiveRecord::Base

  default_scope { order("rank") }

	# challenge matches - another player challenges this player
	has_many :challenge_matches, foreign_key: :challenged_player_id, class_name: 'Match'

	# chellenges - this player challenges another player
	has_many :challenges, foreign_key: :challenger_id, class_name: 'Match'

  # Include default devise modules. Others available are:
  # :token_authenticatable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  def name
    "#{first_name} #{last_name}"
  end

  def self.no_ranked_players?
    where('rank > 0').size == 0    
  end

  def new_player?
    rank.to_i == 0
  end

  def any_challenges?
    !self.challenges.empty?
  end

  def challenge_issued?
    if self.any_challenges?
      self.challenges.last.played_at.nil?
    end
  end

  def any_challenge_matches?
    !self.challenge_matches.empty?
  end

  def challenge_match_pending?
    if self.any_challenge_matches?
      self.challenge_matches.last.played_at.nil?
    end
  end

  def last_challenge
    if challenge_issued?
      challenges.last
    else
      challenge_matches.last
    end
  end

  def add_to_bottom_of_ladder
    bottom_rank = Player.maximum("rank")
    self.rank = bottom_rank + 1
    self.save
  end

  def challenge_reissue_delay? player
    if self.any_challenges?
      re_challenge_time_delay = Ladder::Application.config.re_challenge_time_delay
      last_challenge = self.challenges.where({ challenged_player_id: player.id }).last
      if last_challenge
        if !last_challenge.challenger_victorious?
          last_challenge.played_at.advance(days: re_challenge_time_delay) > Date.current
        end
      end
    end
  end

  def challenge_reissue_date player
    re_challenge_time_delay = Ladder::Application.config.re_challenge_time_delay
    last_challenge = self.challenges.where({ challenged_player_id: player.id }).last
    last_challenge.played_at.advance(days: re_challenge_time_delay)
  end

  def self.within_challenge_range player
    challenge_gap = Ladder::Application.config.challenge_gap
    if (player.rank - challenge_gap.to_i) < 0
      base_rank = 0
    else
      base_rank = player.rank - challenge_gap.to_i
    end
    where("rank > ?", base_rank).limit(challenge_gap.to_i)
  end

  def self.active_ladder
    where("rank > 0")
  end

  def self.new_players
    where("rank = 0")
  end

  def self.adjust_ranks challenger, challenged_player
    if challenger.new_player?
      players = Player.where("rank >= ?", challenged_player.rank)
    else  
      # select players from challenged_player's rank to challenger's rank
      players = Player.where("rank >= ? AND rank <= ?", challenged_player.rank, challenger.rank)
    end
    
    # increase ranks on all players
    players.each do |player|
      player.rank += 1
      player.save
    end

    # set the challenger's rank to stored challenged_player's rank
    challenger.rank = challenged_player.rank
    challenger.save

    # reload the challenged_player's rank
    challenged_player.rank = Player.find(challenged_player.id).rank
    challenged_player.save
  end

  def remove
    # check if challenge pending, if yes, cancel
    if challenge_issued?
      challenges.last.cancel
    end
    if challenge_match_pending?
      challenge_matches.last.cancel
    end
    # delete past activity
    player_activity = Activity.player_activity(self)
    player_activity.delete_all
    # destroy the player
    self.destroy
    # adjust ranks for remaining players
    unless new_player?
      higher_ranked_players = Player.where("rank > ?", self.rank)
      higher_ranked_players.each do |player|
        player.rank -= 1
        player.save
      end
    end
  end

end
