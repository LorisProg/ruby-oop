require './player'
require './board'

class MastermindGame

	def initialize
		@@possible_digits = (1..6)
		@@combination_size = 4
		@player = nil
		@board = nil
	end

def start
	
	welcome
	if play?
		puts "Ok let's start !"
		@board = Board.new
		@player = create_player
		@board.play(generate_code)
	end


end

def welcome
	puts " --------------------------------------------------"
	puts "|                                                  |"
	puts "| Welcome to the Mastermind game written in Ruby ! |"
	puts "|                                                  |"
	puts "|                                                  |"
	puts "|           Made for The Odin Project              |"
	puts "|                                                  |"
	puts "|                                                  |"
	puts " --------------------------------------------------"
	puts ""
	puts " --------------------------------------------------"
	puts "|                                                  |"
	puts "|  The aim of the game is to find the secret code  |"
	puts "|          chosen by the other player.             |"
	puts "|                                                  |"
	puts "|     The combination is a suite of 4 digits       |"
	puts "|    from 1 to 6, each digit can be used several   |"
	puts "|                    times.                        |"
	puts "|                                                  |"
	puts "| After each guess, the codemaker gives a feedback |"
	puts "|                                                  |"
	puts "|      X for a correct digit at the right place    |"
	puts "|   0 for a correct digit but not the right place  |"
	puts "|    (and there's no indication of which digit)    |"
	puts "|                                                  |"
	puts " --------------------------------------------------"
	puts ""
end

def play?
	puts "Are you ready to play ? (y/n)"
	yes_no?
end

def yes_no?(error_message = "Please only answer with (y)es or (n)o :")
	correct_answer = false
	until correct_answer
		answer = gets.chomp
		if answer == "y" || answer == "yes"
			return true
		elsif answer == "n" || answer == "no"
			return false
		else
			puts error_message
		end
	end
end

def create_player
	puts "what's your name ?"
	name = gets.chomp
	Player.new(name, @board)
end

def generate_code
	code = []
	@@combination_size.times do |n|
		code[n] = random_digit		
	end
	code
end

def random_digit
	rand(@@possible_digits)
end


end