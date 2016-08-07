require 'board'

describe Board  do


	describe "#get_feedback" do

		context "@secret code = [1, 3, 5, 2]" do
			
			before do
				@board = Board.new(0)
				@board.secret_code = [1, 3, 5, 2]
			end

			context "guess [1, 4, 2, 5]" do
				it "it returns 'XOO'" do
					expect(@board.get_feedback([1, 4, 2, 5])).to eql("XOO")
				end
			end

			context "guess [6, 1, 3, 2]" do
				it "it returns 'XOO'" do
					expect(@board.get_feedback([6, 1, 3, 2])).to eql("XOO")
				end
			end			
		end

		context "@secret code = [5, 2, 2, 5]" do
			
			before do
				@board = Board.new(0)
				@board.secret_code = [5, 2, 2, 5]
			end

			context "guess [4, 5, 3, 2]" do
				it "it returns 'OO'" do
					expect(@board.get_feedback([4, 5, 3, 2])).to eql("OO")
				end
			end

			context "guess [6, 1, 3, 2]" do
				it "it returns 'O'" do
					expect(@board.get_feedback([6, 1, 3, 2])).to eql("O")
				end
			end

			context "guess [2, 5, 3, 2]" do
				it "it returns 'OOO'" do
					expect(@board.get_feedback([2, 5, 3, 2])).to eql("OOO")
				end
			end				

		end

		context "@secret code = [4, 4, 4, 6]" do
			
			before do
				@board = Board.new(0)
				@board.secret_code = [4, 4, 4, 6]
			end

			context "guess [4, 5, 3, 2]" do
				it "it returns 'X'" do
					expect(@board.get_feedback([4, 5, 3, 2])).to eql("X")
				end
			end

			context "guess [6, 1, 3, 2]" do
				it "it returns 'O'" do
					expect(@board.get_feedback([6, 1, 3, 2])).to eql("O")
				end
			end

			context "guess [2, 5, 3, 2]" do
				it "it returns ''" do
					expect(@board.get_feedback([2, 5, 3, 2])).to eql("nothing")
				end
			end

			context "guess [1, 2, 6, 4]" do
				it "it returns 'OO'" do
					expect(@board.get_feedback([1, 2, 6, 4])).to eql("OO")
				end
			end

			context "guess [4, 2, 6, 4]" do
				it "it returns 'XOO'" do
					expect(@board.get_feedback([4, 2, 6, 4])).to eql("XOO")
				end
			end						

		end

	end

end