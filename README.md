# Ladder app

By *Oto Hlincik*

## Overview

This is a simple app to run a Racquetball Ladder. A ladder is a perpetual competition where each player has a certain rank. The rank is determined by playing **challenge matches** against other players on the ladder. A player can challenge players on the ladder that have higher rank (lower rank number) and are currently above the challenging player on the ladder. If the challenger wins the challenge match, the challenger takes over the rank of the challenged player and the challenged player moves one rank down.

## Basic functionality

At this time, the app allows the racquetball players the following:

* Sign-up to participate in the ladder (creates a user/player account)
* View the Ladder Rankings
* View the current player's Player Profile
* Issue a challenge  
	The challenged player receives notification via email
* Submit challenge match results (both challenger of challenged player)  
	Either challenger or challenged player receives notification via email, depending on who submitted the challenge match results
* New player that signs up for the ladder can challenge two times before he takes the rank of defeated challenged player or is added to the bottom of the ladder
* `not implemented yet` Players are notified and ultimately their ranks are decreased if they breach the challenge inactivity limit

## Configuration

Here are the available configuration variables that can be set in the **config/applicaton.rb**

* `config.challenge_gap`  
	(default: 3)  
	Set the nuber of ranks that players can challenge
* `config.re_challenge_time_delay`  
	(default: 7)  
	Set re-challenge time delay in days that is imposed on challenger if he loses a challenge match
* `config.challenge_inactivity`  
	(default: 14)  
	Set the challenge inactivity in days that results in lowering the player's rank