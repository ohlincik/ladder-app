seed_players = [
	{ rank: 1, first_name: "Bob", last_name: "Uno", email: "1@ladder.com", password: "password", password_confirmation: "password" },
	{ rank: 2, first_name: "Peter", last_name: "Deuce", email: "2@ladder.com", password: "password", password_confirmation: "password" },
	{ rank: 3, first_name: "Frank", last_name: "Treehorn", email: "3@ladder.com", password: "password", password_confirmation: "password" },
	{ rank: 4, first_name: "Andy", last_name: "Foreman", email: "4@ladder.com", password: "password", password_confirmation: "password" },
	{ rank: 5, first_name: "Chester", last_name: "Fife", email: "5@ladder.com", password: "password", password_confirmation: "password" },
	{ rank: 6, first_name: "Jack", last_name: "Sexton", email: "6@ladder.com", password: "password", password_confirmation: "password" },
	{ rank: 7, first_name: "Graham", last_name: "Sieben", email: "7@ladder.com", password: "password", password_confirmation: "password" },
	{ rank: 8, first_name: "Carl", last_name: "Octobus", email: "8@ladder.com", password: "password", password_confirmation: "password" },
	{ rank: 9, first_name: "Hank", last_name: "Niner", email: "9@ladder.com", password: "password", password_confirmation: "password" },
	{ rank: 10, first_name: "Paul", last_name: "Decton", email: "10@ladder.com", password: "password", password_confirmation: "password" }
]

Player.destroy_all
Match.destroy_all

seed_players.each do |seed_player|
	new_player = Player.new(seed_player)
	new_player.skip_confirmation!
	new_player.save
end