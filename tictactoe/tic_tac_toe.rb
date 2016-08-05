# Tic Tac Toe for The Odin Project

#for debugging
#require "pry"


class Board

	def initialize
		@status = {}
		self.clear
	end

	def draw
		puts " #{@status[:"1"]} | #{@status[:"2"]} | #{@status[:"3"]} "
		puts "-----------"
		puts " #{@status[:"4"]} | #{@status[:"5"]} | #{@status[:"6"]} "
		puts "-----------"
		puts " #{@status[:"7"]} | #{@status[:"8"]} | #{@status[:"9"]} "
	end

	def new_move(position, sign)
		@status[position] = sign
	end

	def clear
		1.upto(9) { |n| @status[n.to_s.to_sym] = " " }
	end

end

class Player

	attr_reader :positions, :name

	def initialize(name, sign, board)
		@name = name
		@sign = sign
		@board = board
		@positions = []
		@@all_positions = []
	end

	def move
		puts "It's your turn #{@name}, please enter your next move :"
		puts "(number from 1 to 9)"
		correct_move = false

		while !correct_move
			move = gets.chomp
			if (move.split & @@all_positions).size == 0 && move.to_i.between?(1,9)
				@board.new_move(move.to_sym, @sign)
				@positions << move.to_i
				@@all_positions << move.to_s
				correct_move = true
			else
				puts "This position is already taken !" if (move.split & @@all_positions).size != 0
				puts "Only a number between 1 and 9 is valid" if !move.to_i.between?(1,9)
				puts "Please choose another move."
			end
		end
	end

	def self.all_positions
		@@all_positions
	end

	def clear
		@positions = []
		@@all_positions = []
	end

end


class TicTacToeGame

	def initialize
		@board = Board.new
		
		welcome

		@player1 = create_player("Player 1")
		@player2 = create_player("Player 2")
		@winner = ""
		
		system('clear')

		play
	end

	public

	def play
			
		player1_to_play = true
		player2_to_play = false
			
		@board.draw

		while !game_over?

			@player1.move if player1_to_play
			@player2.move if player2_to_play
				
			player1_to_play, player2_to_play = player2_to_play, player1_to_play

			system('clear')
			@board.draw

		end

		end_of_game

	end

	private

	def welcome
		puts "Welcome to Tic Tac Toe written in Ruby !"
		puts ""
	end

	def create_player(id)
		puts "#{id} what's your name ?"
		name = gets.chomp
		sign = ""
		if !@sign_taken
			puts "You get to choose your symbol! What do you prefer ? ( X or O )"
			while sign != "X" && sign != "O"
				sign = gets.chomp.upcase
				@sign_taken = sign
				puts "Wrong symbol, please only select X or O" if sign != "X" && sign != "O"
			end
		else
			sign = "X" if @sign_taken == "O"
			sign = "O" if @sign_taken == "X"
		end
		Player.new(name, sign, @board)
	end

	def game_over?
		winning_positions = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
		
		winning_positions.each do |win| 
			if (win & @player1.positions).size == 3 || (win & @player2.positions).size == 3 
				@winner = @player1.name if (win & @player1.positions).size == 3
				@winner = @player2.name if (win & @player2.positions).size == 3
				return true
			end
		end

		return true if Player.all_positions.size == 9

		false 
	end

	def end_of_game
		if @winner != ""
		puts "Congratulations ! #{@winner} wins !"
		else
			puts "Game Over ! Nobody won ..."
		end

		if play_again?
			new_game
		else
			puts "Thank you for playing !"
		end
	end

	def play_again?
		puts "Would you like to play again ? (y/n)"
		valid_answer = false

		until valid_answer
			valid_answer = gets.chomp.downcase
			if valid_answer == "y"
				return true
			elsif valid_answer == "n"
				return false
			else
				puts "Please answer only with y or n"
				valid_answer = false
			end
		end
	end

	def new_game
		@board.clear
		@player1.clear
		@player2.clear
		system('clear')
		play
	end

end


#Start the game
system('clear')
TicTacToeGame.new