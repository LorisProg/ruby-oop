require './mastermind'

class Board

	attr_writer :secret_code

	def initialize(mastermind)
		@guess_left = 12
		@current_guess = []
		@all_guesses = []
		@@possible_digits = (1..6).to_a
		@secret_code = nil
		@mastermind = mastermind
		@guess_set = generate_pool
	end

	def play(secret_code, ai=false)
		@secret_code = secret_code
		until game_over?
			draw
			if ai
				computer_guess(get_feedback(@current_guess))
			else
				get_guess
			end
		end
	end

#	private

	def draw(show=false)
		system ('clear')

		@mastermind.instructions

		puts ""
		puts "           SECRECT CODE     "
		if show
			puts "      || #{@secret_code[0]} || #{@secret_code[1]} || #{@secret_code[2]} || #{@secret_code[3]} ||"
		else
			puts "      || X || X || X || X ||"
		end
		puts ""
		puts "      You have #{@guess_left} guesses left"

		
		if @all_guesses.size > 0
			0.upto(@all_guesses.size - 1) do |n|
				print "      || #{@all_guesses[n][0]} || #{@all_guesses[n][1]} || #{@all_guesses[n][2]} || #{@all_guesses[n][3]} ||"
				puts "   feedback : #{get_feedback(@all_guesses[n])}"
			end
		end

		@guess_left.times do |n|
			puts "      || . || . || . || . ||"
		end

		puts ""

	end

	def get_guess
		puts "What's your guess ?"
		puts "(write the 4 digits next to each other like this : 2532 )"
		guess = gets.chomp
		guess = to_code(guess)

		if valid_code?(guess)
			validate_guess(guess)
		else
			puts ""
			puts "------------------------------"
			puts "You did not enter a valid code"
			puts "------------------------------"
			puts "Only digit between 1 and 6 authorized"
			get_guess
		end
	end

	def validate_guess(guess)
		@current_guess = guess
		@all_guesses << guess
		@guess_left -= 1
	end

	def to_code(string)
		code = []
		string = string.split("")
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

	def game_over?

		if @current_guess == @secret_code
			draw(true)
			puts "Congratulations you won !"
			return true 
		end

		if @guess_left == 0
			draw(true)
			puts "Game Over"
			return true 
		end

		false
	end


	def get_feedback(guess, secret_code=@secret_code)

		return "" if guess == []

		secret_copy = secret_code.dup
		guess_copy = guess.dup
		feedback = []

		(guess_copy.size - 1).downto(0) do |n|
			if guess_copy[n] == secret_copy[n]
				feedback << "X"
				guess_copy.delete_at(n)
				secret_copy.delete_at(n)
			end
		end

		(guess_copy.size - 1).downto(0) do |x|
			(secret_copy.size - 1).downto(0) do |y|
				if guess_copy[x] == secret_copy[y]
					feedback << "O"
					guess_copy.delete_at(x)
					secret_copy.delete_at(y)
				end
			end
		end

		if feedback == []
			feedback = ["nothing"]
		end
		feedback.join
	end	


	def computer_guess(feedback)

		if feedback == ""
			validate_guess([1,1,2,2])
		else

			(@guess_set.size - 1).downto(0) do |n|
				if get_feedback(@current_guess, @guess_set[n]) != feedback
					@guess_set.delete_at(n)
				end
			end

			puts "The computer has chosen his next guess. Press <enter> to let it play."
			gets.chomp
			validate_guess(@guess_set[0])
		end

	end

	def generate_pool
	pool = []

	1.upto(6) do |a|
		1.upto(6) do |b|
			1.upto(6) do |c|
				1.upto(6) do |d|
					pool << [a, b, c, d]
				end
			end
		end
	end

	pool
	end

end