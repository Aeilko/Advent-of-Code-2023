require_relative '../lib/aoc'

module Day02
	extend AOC::Day

	@num = 2
	@ans_test1 = 8
	@ans_test2 = 2286

	def self.solve_part1(input)
		r = 0
		h = {
			"red" => 12,
			"green" => 13,
			"blue" => 14,
		}

		regx = /(\d+) (red|blue|green)/
		input.lines.each do |line|
			fail = false
			line.scan(regx).each do |x|
				if h[x[1]] < x[0].to_i
					fail = true
					break
				end
			end

			r += line.match(/Game (?<id>\d+):/)[:id].to_i unless fail
		end

		return r
	end

	def self.solve_part2(input)
		r = 0

		regx = /(\d+) (red|blue|green)/
		input.lines.each do |line|
			h = {
				"red" => 0,
				"green" => 0,
				"blue" => 0,
			}

			line.scan(regx).each do |x|
				h[x[1]] = [h[x[1]], x[0].to_i].max
			end

			r += h["red"]*h["green"]*h["blue"]
		end

		return r
	end
end

Day02.run
