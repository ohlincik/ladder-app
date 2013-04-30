class Player < ActiveRecord::Base

  default_scope { order("rank") }

	# challenge matches - another player challenges this player
	has_many :challenge_matches, foreign_key: :challenged_player_id, class_name: 'Match'

	# chellenges - this player challenges another player
	has_many :challenges, foreign_key: :challenger_id, class_name: 'Match'

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :rank, :first_name, :last_name, :phone, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

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

  def add_to_bottom_of_ladder
    bottom_rank = Player.maximum("rank")
    self.rank = bottom_rank + 1
    self.save
  end

  def self.within_challenge_range player
    challenge_gap = Ladder::Application.config.challenge_gap
    where("rank > ?", player.rank - challenge_gap.to_i).limit(challenge_gap.to_i)    
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
  end

end
