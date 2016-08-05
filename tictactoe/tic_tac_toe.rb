# Tic Tac Toe for The Odin Project

# method to draw the board


class Board

	def initialize
		@status = {}
		1.upto(9) { |n| @status[n.to_s.to_sym] = " " }
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

end

class Player

	attr_reader :positions

	def initialize(name, sign, board)
		@name = name
		@sign = sign
		@board = board
		@positions = []
	end

	def move
		puts "It's your turn #{@name}, please enter your next move :"
		puts "(number from 1 to 9)"
		move = gets.chomp
		@board.new_move(move.to_s.to_sym, @sign)
		@positions << move
	end

end


class TicTacToeGame

	def initialize
		puts "Welcome to Tic Tac Toe written in Ruby !"
		puts ""
		puts "Player 1 what's your name ?"
		@player1_name = gets.chomp
		puts "You get to choose your symbol! What do you prefer ? ( X or O )"
		@player1_sign = gets.chomp
		puts "Player 2 what's your name ?"
		@player2_name = gets.chomp
		puts "You get to choose your symbol! What do you prefer ? ( X or O )"
		@player2_sign = gets.chomp
#beta version
		playing_board = Board.new
		@board = playing_board
		player1 = Player.new(@player1_name, @player1_sign, @board)
		player2 = Player.new(@player2_name, @player2_sign, @board)
		@player1 = player1
		@player2 = player2
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

	end

	private

	def game_over?
		winning_positions = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
		
		winning_positions.each do |win| 
			if (win & @player1.positions).size == 3 || (win & @player2.positions).size == 3 
				return true
			end
		end
		false 
	end

end