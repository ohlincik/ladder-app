seed_players = [
	{ rank: 1, first_name: "Bob", last_name: "Uno", email: "ohlincik+t1@gmail.com", password: "password", password_confirmation: "password" },
	{ rank: 2, first_name: "Peter", last_name: "Deuce", email: "ohlincik+t2@gmail.com", password: "password", password_confirmation: "password" },
	{ rank: 3, first_name: "Frank", last_name: "Treehorn", email: "ohlincik+t3@gmail.com", password: "password", password_confirmation: "password" },
	{ rank: 4, first_name: "Andy", last_name: "Foreman", email: "ohlincik+t4@gmail.com", password: "password", password_confirmation: "password" },
	{ rank: 5, first_name: "Chester", last_name: "Fife", email: "ohlincik+t5@gmail.com", password: "password", password_confirmation: "password" },
	{ rank: 6, first_name: "Jack", last_name: "Sexton", email: "ohlincik+t6@gmail.com", password: "password", password_confirmation: "password" },
	{ rank: 7, first_name: "Graham", last_name: "Sieben", email: "ohlincik+t7@gmail.com", password: "password", password_confirmation: "password" },
	{ rank: 8, first_name: "Carl", last_name: "Octobus", email: "ohlincik+t8@gmail.com", password: "password", password_confirmation: "password" },
	{ rank: 9, first_name: "Hank", last_name: "Niner", email: "ohlincik+t9@gmail.com", password: "password", password_confirmation: "password" },
	{ rank: 10, first_name: "Paul", last_name: "Decton", email: "ohlincik+t10@gmail.com", password: "password", password_confirmation: "password" }
]

Player.destroy_all
Match.destroy_all

seed_players.each do |seed_player|
	new_player = Player.new(seed_player)
	new_player.skip_confirmation!
	new_player.save
end