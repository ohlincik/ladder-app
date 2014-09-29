jQuery ->
  $("a.btn-lg").on "click", (e) ->
    e.preventDefault
    $(@).parent().addClass("active")
    $game_input = $(@).parent().siblings(".game-input")
    $game_output = $game_input.siblings(".game-output")
    $game_input.toggle()
    $game_output.toggle()

  $(".game-input a").on "click", (e) ->
    e.preventDefault

    # process the clicked button and set the current score value
    value = $(@).text()
    $game_input = $(@).parents(".game-input")
    $game_output = $game_input.siblings(".game-output")
    $active_section = $game_input.siblings(".active")
    $clicked_button = $active_section.children("a")
    $clicked_button.text(value)
    $active_section.children("input").val(value)
    $active_section.removeClass("active")

    # highlight and disable the button for game winner
    if $clicked_button.hasClass('challenger')
      $active_section.siblings(".game-output").children('a.challenged-player').addClass('btn-success disabled').removeClass('btn-default')
    else
      $active_section.siblings(".game-output").children('a.challenger').addClass('btn-success disabled').removeClass('btn-default')

    # hide the score picker and display the score buttons
    $game_input.toggle()
    $game_output.toggle()

    # set the current game scores for evaluation
    game1_challenger_score = parseInt($('#game-1 .challenger').text().trim())
    game1_challenged_player_score = parseInt($('#game-1 .challenged-player').text().trim())
    game2_challenger_score = parseInt($('#game-2 .challenger').text().trim())
    game2_challenged_player_score = parseInt($('#game-2 .challenged-player').text().trim())
    game3_challenger_score = parseInt($('#game-3 .challenger').text().trim())
    game3_challenged_player_score = parseInt($('#game-3 .challenged-player').text().trim())     

    # determine if the score is valid and display 'Game 3' input if needed
    score_index = 0
    if game1_challenger_score == 15 && game1_challenged_player_score < 15
      score_index = 10

    if game1_challenger_score < 15 && game1_challenged_player_score == 15
      score_index = 1

    if game2_challenger_score == 15 && game2_challenged_player_score < 15
      score_index = score_index + 10
    
    if game2_challenger_score < 15 && game2_challenged_player_score == 15
      score_index = score_index + 1

    if score_index == 11
      $('#game-3').show()
      if game3_challenger_score == 15 && game3_challenged_player_score < 15
        score_index = score_index + 10
      
      if game3_challenger_score < 15 && game3_challenged_player_score == 15
        score_index = score_index + 1

    else
      $('#game-3').hide()
    
    # enable the Submit button if the sore is correct
    if score_index == 20 || score_index == 2 || score_index == 21 || score_index == 12
      $('input[type=submit]').removeClass('disabled')
    else
      $('input[type=submit]').addClass('disabled')

    # display some log info for debugging purposes
    # console.log "Game 1 Challenger: #{game1_challenger_score}"
    # console.log "Game 1 Challenged Player: #{game1_challenged_player_score}"
    # console.log "Game 2 Challenger: #{game2_challenger_score}"
    # console.log "Game 2 Challenged Player: #{game2_challenged_player_score}"
    # console.log "Score Index: #{score_index}"