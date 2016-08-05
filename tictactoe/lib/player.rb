#for debugging
#require "pry"

class Player

	attr_reader :positions, :name

	@@current_player = 0
	@@player1 = nil


	def initialize(name, sign, board)
		@name = name
		@sign = sign
		@board = board
		@positions = []
		@@all_positions = []
		@@current_player += 1
		if @@current_player == 1
			@@player1 = self
		end
	end

	def move

		if self.name != "Computer"
			puts "It's your turn #{@name}, please enter your next move :"
			puts "(number from 1 to 9)"
		end
		
		correct_move = false

		while !correct_move
			if self.name == "Computer"
				move = computer_play
			else
				move = gets.chomp
			end
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
		if self.name == "Computer"
			puts "The Computer has chosen a move, press <enter> to let it play."
			gets
		end
	end

	def computer_play

		move = 0

		winning_positions = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

		winning_positions.each do |win| 
			if (win & self.positions).size == 2
				move = (win - self.positions).join if ((win - self.positions).join.split & @@all_positions).size == 0
			elsif (win & @@player1.positions).size == 2
				move = (win - @@player1.positions).join if ((win - @@player1.positions).join.split & @@all_positions).size == 0
			end
		end

		if move == 0
			until (move.to_s.split & @@all_positions).size == 0 && move != 0
				move = rand(1..9)
			end
		end

		move.to_s
	end

	def self.all_positions
		@@all_positions
	end

	def clear
		@positions = []
		@@all_positions = []
	end

end