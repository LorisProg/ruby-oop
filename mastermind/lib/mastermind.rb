require './board.rb'

class MastermindGame

	def initialize
		@@possible_digits = (1..6)
		@@combination_size = 4
		@player = nil
		@board = nil
	end

def start
	
	welcome
	instructions
	if ready_play?
		puts "Ok let's start !"
		play
	end

	puts "Thanks you for playing Mastermind ! Hope you liked it !"
end


def welcome
	puts "   --------------------------------------------------"
	puts "  |                                                  |"
	puts "  | Welcome to the Mastermind game written in Ruby ! |"
	puts "  |                                                  |"
	puts "  |                                                  |"
	puts "  |           Made for The Odin Project              |"
	puts "  |                                                  |"
	puts "  |                                                  |"
	puts "   --------------------------------------------------"
	puts ""
end

def instructions
	puts "   --------------------------------------------------"
	puts "  |                                                  |"
	puts "  |  The aim of the game is to find the secret code  |"
	puts "  |          chosen by the other player.             |"
	puts "  |                                                  |"
	puts "  |     The combination is a suite of 4 digits       |"
	puts "  |    from 1 to 6, each digit can be used several   |"
	puts "  |                    times.                        |"
	puts "  |                                                  |"
	puts "  | After each guess, the codemaker gives a feedback |"
	puts "  |                                                  |"
	puts "  |      X for a correct digit at the right place    |"
	puts "  |   O for a correct digit but not the right place  |"
	puts "  |    (and there's no indication of which digit)    |"
	puts "  |                                                  |"
	puts "   --------------------------------------------------"
	puts ""

end

private

def ready_play?
	yes_no?("Are you ready to play ? (y/n)")
end

def yes_no?(question)
	puts question
	correct_answer = false
	until correct_answer
		answer = gets.chomp
		if answer == "y" || answer == "yes"
			return true
		elsif answer == "n" || answer == "no"
			return false
		else
			puts "Please only answer with (y)es or (n)o :"
		end
	end
end


def play
	@board = Board.new(self)

	game_type = guesser_or_creator

	if game_type == "guesser"
		@board.play(generate_code)

	elsif game_type == "creator"
		puts "Please chose a code"
		puts "(write the 4 digits next to each other like this : 6534 )"
		correct_answer = false
		until correct_answer
			code = gets.chomp

			code = @board.to_code(code)

			if @board.valid_code?(code)
				@board.play(code, true)
				correct_answer = true
			else
				puts ""
				puts "------------------------------"
				puts "You did not enter a valid code"
				puts "------------------------------"
				puts "Only digit between 1 and 6 authorized"
			end
		end
	end
	
	play if new_game?
end

def generate_code
	code = []
	@@combination_size.times do |n|
		code[n] = rand(1..6)		
	end
	code
end

def new_game?
	puts ""
	puts "-----------------------------------"
	yes_no? "Would you like to play a new game ? (y/n)"
end

def guesser_or_creator
	puts "Would you like to be the (g)uesser or (c)reator of the code ?"
	correct_answer = false
	until correct_answer
		answer = gets.chomp
		if answer == "g" || answer == "guesser"
			return "guesser"
		elsif answer == "c" || answer == "creator"
			return "creator"
		else
			puts "Please only answer with (g)uesser or (c)reator :"
		end
	end
end

end