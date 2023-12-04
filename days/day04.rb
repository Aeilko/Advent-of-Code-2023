require_relative '../lib/aoc'

module Day04
	extend AOC::Day

	@num = 4
	@ans_test1 = 13
	@ans_test2 = 30

	def self.solve_part1(input)
		r = 0

		input.lines.each do |line|
			s = parse_line(line)
			r += 2 ** (s-1) if s > 0
		end

		return r
	end

	def self.solve_part2(input)
		r = 0

		i = 0
		cards = Array.new(input.lines.length, 1)
		input.lines.each do |line|
			s = parse_line(line)

			(i+1..i+s).each do |j|
				break if j >= cards.length
				cards[j] += cards[i]
			end
			r += cards[i]
			i += 1
		end

		return r
	end

	def self.parse_line(line)
		_, nums = line.split(": ")
		winners, nums = nums.split(" | ")
		return (winners.split & nums.split).length
	end
end

Day04.run
