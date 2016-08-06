#require "pry"

class Board

	def initialize
		@guess_left = 12
		@@possible_digits = (1..6).to_a
	end

	def play(secret_code)
		draw
		get_guess
	end

	def draw
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
		puts "(write each digit separated by commas like this : 2, 5, 3, 2"
		guess = gets.chomp
		guess = to_code(guess)

		if valid_code?(guess)
			puts "Your code is valid"
		else
			puts "You did not enter a valid code"
			get_guess
		end
	end

	def to_code(string)
		code = []
		string = string.split(",")
		string.each do |item|
			begin
				code << item.to_i
			rescue Exception => e
				code = "error"
				return code
			end
		end
		code
	end

	def valid_code?(code)
		
		return false if code.size != 4
		
		code.each do |digit|
			if !@@possible_digits.include?digit
				return false
			end
		end
		true
	end

end