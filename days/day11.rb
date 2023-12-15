require_relative '../lib/aoc'
require_relative '../lib/grid'

module Day11
	extend AOC::Day

	@num = 11
	@ans_test1 = 374
	@ans_test2 = 82000210

	def self.solve_part1(input)
		galaxies, empty_rows, empty_cols = parse_input(input)

		r = 0
		galaxies.each_with_index do |g, i|
			(i+1...galaxies.length).each do |j|
				to_g = galaxies[j]
				min_x, max_x = [g[0], to_g[0]].minmax
				min_y, max_y = [g[1], to_g[1]].minmax

				s = (max_x-min_x) + (max_y-min_y)
				s += empty_cols.count{|x| x.between?(min_x, max_x)}
				s += empty_rows.count{|y| y.between?(min_y, max_y)}
				r += s
			end
		end
		return r
	end

	def self.solve_part2(input)
		galaxies, empty_rows, empty_cols = parse_input(input)

		r = 0
		galaxies.each_with_index do |g, i|
			(i+1...galaxies.length).each do |j|
				to_g = galaxies[j]
				min_x, max_x = [g[0], to_g[0]].minmax
				min_y, max_y = [g[1], to_g[1]].minmax

				s = (max_x-min_x) + (max_y-min_y)
				s += empty_cols.count{|x| x.between?(min_x, max_x)}*999999
				s += empty_rows.count{|y| y.between?(min_y, max_y)}*999999
				r += s
			end
		end
		return r
	end

	def self.parse_input(input)
		grid = Grid::string_to_grid(input)
		max_x = grid[0].length-1
		max_y = grid.length-1

		empty_rows = []
		empty_cols = []
		(0..max_x).each do |x|
			empty = true
			(0..max_y).each do |y|
				if grid[y][x] != "."
					empty = false
					break
				end
			end
			empty_cols << x if empty
		end
		(0..max_y).each do |y|
			empty = true
			(0..max_x).each do |x|
				if grid[y][x] != "."
					empty = false
					break
				end
			end
			empty_rows << y if empty
		end

		galaxies = []
		grid.each_with_index do |row, y|
			row.split("").each_with_index do |c, x|
				galaxies << [x, y] if c == "#"
			end
		end

		return [galaxies, empty_rows, empty_cols]
	end
end

Day11.run
