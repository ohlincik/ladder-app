class PlayerMailer < ActionMailer::Base
  default from: "LECOM Ladder <mailer@lecomladder.com>", return_path: "ohlincik@gmail.com"

  def challenge_email(challenger, challenged_player, message)
  	@challenger = challenger
  	@challenged_player = challenged_player
  	@message = message
  	mail(to: "#{challenged_player.first_name} #{challenged_player.last_name} <#{challenged_player.email}>", subject: "You've been challenged")
  end
end
