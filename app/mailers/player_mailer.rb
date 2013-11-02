class PlayerMailer < ActionMailer::Base
  default from: "LECOM Ladder <mailer@lecomladder.com>", return_path: "ohlincik@gmail.com"

  def challenge_email(challenger, challenged_player, message, include_scheduling_info)
  	@challenger = challenger
  	@challenged_player = challenged_player
  	@message = message
    if include_scheduling_info
      @scheduling_info = challenger.scheduling_info
    else
      @scheduling_info = false
    end
  	mail(
      to: "#{challenged_player.name} <#{challenged_player.email}>",
      from: "#{challenger.name} <mailer@lecomladder.com>",
      reply_to: challenger.email,
      subject: "You've been challenged"
    )
  end

  def challenge_completed_by_challenger_email(match)
  	@match = match
  	mail(
      to: "#{match.challenged_player.name} <#{match.challenged_player.email}>",
      from: "#{match.challenger.name} <mailer@lecomladder.com>",
      reply_to: match.challenger.email,
      subject: "Your challenge match scores have been submitted"
    )
  end

  def challenge_completed_by_challenged_player_email(match)
  	@match = match
		mail(
      to: "#{match.challenger.name} <#{match.challenger.email}>",
      from: "#{match.challenged_player.name} <mail@lecomladder.com>",
      reply_to: match.challenged_player.email,
      subject: "Your challenge match scores have been submitted"
    )
  end

  def challenge_canceled_email(match)
    @challenger_name = "#{match.challenger.name}"
    mail(
      to: "#{match.challenged_player.name} <#{match.challenged_player.email}>",
      from: "#{match.challenger.name} <mailer@lecomladder.com>",
      reply_to: match.challenger.email,
      subject: "Your challenge match was canceled"
    )
  end
end
