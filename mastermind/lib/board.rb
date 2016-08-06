require "pry"

class Board

	def initialize
		@guess_left = 12
	end

	def play(secret_code)
		draw
		get_guess
	end

	def draw
		binding.pry
		puts "        SECRECT CODE     "
		puts "   || X || X || X || X ||"
		puts ""
		puts "   You have #{@guess_left} guesses left"

		@guess_left.times do |n|
			puts "   || . || . || . || . ||"
		end
	end

	def get_guess
		puts "What's your guess ?"
		guess = gets.chomp
	end

end