# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
# Seed the test players with appropriate ranks
#
Player.create!(:rank => 1, :first_name => "Bob", :last_name => "Uno", :email => "ohlincik+t1@gmail.com", :password => "password", :password_confirmation => "password", :confirmed_at => DateTime.current)
Player.create!(:rank => 2, :first_name => "Peter", :last_name => "Deuce", :email => "ohlincik+t2@gmail.com", :password => "password", :password_confirmation => "password", :confirmed_at => DateTime.current)
Player.create!(:rank => 3, :first_name => "Frank", :last_name => "Treehorn", :email => "ohlincik+t3@gmail.com", :password => "password", :password_confirmation => "password", :confirmed_at => DateTime.current)
Player.create!(:rank => 4, :first_name => "Andy", :last_name => "Foreman", :email => "ohlincik+t4@gmail.com", :password => "password", :password_confirmation => "password", :confirmed_at => DateTime.current)
Player.create!(:rank => 5, :first_name => "Chester", :last_name => "Fife", :email => "ohlincik+t5@gmail.com", :password => "password", :password_confirmation => "password", :confirmed_at => DateTime.current)
Player.create!(:rank => 6, :first_name => "Jack", :last_name => "Sexton", :email => "ohlincik+t6@gmail.com", :password => "password", :password_confirmation => "password", :confirmed_at => DateTime.current)
Player.create!(:rank => 7, :first_name => "Graham", :last_name => "Sieben", :email => "ohlincik+t7@gmail.com", :password => "password", :password_confirmation => "password", :confirmed_at => DateTime.current)
Player.create!(:rank => 8, :first_name => "Carl", :last_name => "Octobus", :email => "ohlincik+t8@gmail.com", :password => "password", :password_confirmation => "password", :confirmed_at => DateTime.current)
Player.create!(:rank => 9, :first_name => "Hank", :last_name => "Niner", :email => "ohlincik+t9@gmail.com", :password => "password", :password_confirmation => "password", :confirmed_at => DateTime.current)
Player.create!(:rank => 10, :first_name => "Paul", :last_name => "Decton", :email => "ohlincik+t10@gmail.com", :password => "password", :password_confirmation => "password", :confirmed_at => DateTime.current)