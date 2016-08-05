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