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
		self.draw
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
			if (move.split & @@all_positions).size == 0
				@board.new_move(move.to_sym, @sign)
				@positions << move.to_i
				@@all_positions << move.to_s
				correct_move = true
			else
				puts "This position is already taken !"
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
		
		self.play
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
			
		end

		if @winner != ""
		puts "Congratulations ! #{@winner} wins !"
		else
			puts "Game Over ! Nobody won ..."
		end

#		puts "Would you like to play a new game ?"
# => next thing to implement New Game

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

end


#Start the game
TicTacToeGame.new