class PlayerMailer < ActionMailer::Base
  default from: "LECOM Ladder <mailer@lecomladder.com>", return_path: "ohlincik@gmail.com"

  def challenge_email(challenger, challenged_player, message)
  	@challenger = challenger
  	@challenged_player = challenged_player
  	@message = message
  	mail(to: "#{challenged_player.first_name} #{challenged_player.last_name} <#{challenged_player.email}>", subject: "You've been challenged")
  end

  def challenge_completed_by_challenger_email(match)
  	@match = match
  	mail(to: "#{match.challenged_player.first_name} #{match.challenged_player.last_name} <#{match.challenged_player.email}>", subject: "Your challenge match scores have been submitted.")
  end

  def challenge_completed_by_challenged_player_email(match)
  	@match = match
		mail(to: "#{match.challenger.first_name} #{match.challenger.last_name} <#{match.challenger.email}>", subject: "Your challenge match scores have been submitted.")
  end
end
