require './board.rb'
require './mastermind'
require 'benchmark'

###
### You need to comment the gets.chomp line 176 of board.rb
### for the test to work !!!
###
### Don't forget to uncomment when you're done
###


def test_ai(number_of_tests)

	time = Benchmark.measure {

	computer_wins = 0
	sum_tries = 0
	mastermind = MastermindGame.new

	number_of_tests.times do |n|
		board = Board.new(mastermind)
		win, tries = board.play(mastermind.generate_code, true)
		computer_wins += win
		sum_tries += tries
	end

	puts "After #{number_of_tests} tests, the computer won #{computer_wins} times."
	puts "Winning rate : #{(computer_wins / number_of_tests) * 100}%"
	puts ""
	puts "Average number of guesses to win : #{sum_tries.to_f / number_of_tests}"

	}
	puts ""
	puts "Time Benchmark for the #{number_of_tests} games tested (in seconds):"
	puts time

end