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