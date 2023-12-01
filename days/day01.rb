require_relative '../lib/aoc'

module Day01
	extend AOC::Day

	@num = 1
	@ans_test1 = 209
	@ans_test2 = 281

	def self.solve_part1(input)
		r = 0

		input.lines.each { |line|
			r += line_to_num(line)
		}

		r
	end

	def self.solve_part2(input)
		r = 0

		nums = [
			["one", "o1e"],
			["two", "t2o"],
			["three", "t3e"],
			["four", "f4r"],
			["five", "f5e"],
			["six", "s6x"],
			["seven", "s7n"],
			["eight", "e8t"],
			["nine", "n9e"],
		]
		input.lines.each do |line|
			nums.each { |find, replace| line.gsub!(find, replace) }
			r += line_to_num(line)
		end

		r
	end

	def self.line_to_num(line)
		first_num = last_num = nil
		line.split('').each do |c|
			if c =~ /[0-9]/
				first_num = c if first_num.nil?
				last_num = c
			end
		end

		"#{first_num}#{last_num}".to_i
	end
end

Day01.run
