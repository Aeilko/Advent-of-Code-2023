require_relative '../lib/aoc'

module Day09
	extend AOC::Day

	@num = 9
	@ans_test1 = 114
	@ans_test2 = 2

	def self.solve_part1(input)
		r = 0
		input.lines.map{ |l| l.strip  }.each do |line|
			sequence = line.scan(/-?\d+/).map(&:to_i)
			history = parse_history(sequence)

			cur_val = 0
			history.reverse_each do |seq|
				cur_val += seq[-1]
			end
			r += cur_val
		end
		r
	end

	def self.solve_part2(input)
		r = 0
		input.lines.map{ |l| l.strip  }.each do |line|
			sequence = line.scan(/-?\d+/).map(&:to_i)
			history = parse_history(sequence)

			cur_val = 0
			history.reverse_each do |seq|
				cur_val = seq[0]-cur_val
			end
			r += cur_val
		end
		r
	end

	def self.parse_history(sequence)
		history = [sequence]
		while true
			new_seq = []
			sequence.each_with_index do |s, i|
				next if i == 0
				new_seq << s-sequence[i-1]
			end
			history << new_seq
			sequence = new_seq

			break if sequence.all? { |s| s == 0 }
		end
		history
	end
end

Day09.run
