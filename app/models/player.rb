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

  def adjust_ranks challenged_player
    # select players from challenged_player's rank to challenger's rank
    players = Player.where("rank >= ? AND rank <= ?", challenged_player.rank, self.rank)

    # increase ranks on all players
    players.each do |player|
      player.rank = player.rank + 1
      player.save
    end

    # set the challenger's rank to stored challenged_player's rank
    self.rank = challenged_player.rank
    self.save
  end

end
