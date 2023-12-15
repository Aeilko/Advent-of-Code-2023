require_relative '../lib/aoc'
require_relative '../lib/grid'

module Day10
	extend AOC::Day

	@num = 10
	@ans_test1 = 8
	@ans_test2 = 10

	CONNECTS = {
		[1, 0]  => ["-", "7", "J"],
		[0, 1]  => ["|", "L", "J"],
		[-1, 0] => ["-", "L", "F"],
		[0, -1] => ["|", "7", "F"],
	}

	NEIGHBORS = {
		"|" => [[0, -1], [0, 1]],
		"-" => [[-1, 0], [1, 0]],
		"L" => [[0, -1], [1, 0]],
		"J" => [[0, -1], [-1, 0]],
		"7" => [[-1, 0], [0, 1]],
		"F" => [[1, 0], [0, 1]],
	}

	def self.solve_part1(input)
		grid = Grid.string_to_grid(input)

		s_x, s_y = find_and_replace_start(grid)
		visited = find_loop(grid, s_x, s_y)

		return visited.values.max
	end

	def self.solve_part2(input)
		grid = Grid.string_to_grid(input)
		s_x, s_y = find_and_replace_start(grid)
		visited = find_loop(grid, s_x, s_y)

		r = 0
		grid.each_with_index do |row, y|
			in_loop = false
			last_corner = nil
			row.split("").each_with_index do |c, x|
				if visited.key?([x, y])
					# This coord is part of the loop
					if c == "|" or (c == "J" and last_corner == "F") or (c == "7" and last_corner == "L")
						in_loop = !in_loop
					end

					last_corner = c if ["7", "J", "L", "F"].include?(c)
				else
					# Not part of the loop
					r += 1 if in_loop
				end
			end
		end

		return r
	end

	def self.find_loop(grid, s_x, s_y)
		to_visit = {}
		visited = {}
		to_visit[[s_x, s_y]] = 0
		while to_visit.length > 0
			coords, cost = to_visit.shift
			x, y = coords
			visited[[x, y]] = cost

			NEIGHBORS[grid[y][x]].each do |dx, dy|
				nx = x+dx
				ny = y+dy
				nc = cost+1

				next if visited.key?([nx, ny])

				if to_visit.key?([nx, ny])
					if to_visit[[nx, ny]] > nc
						to_visit[[nx, ny]] = nc
					end
				else
					to_visit[[nx, ny]] = nc
				end
			end
		end

		return visited
	end

	def self.find_and_replace_start(grid)
		s_x = s_y = -1
		grid.each_with_index do |line, y|
			line.split("").each_with_index do |char, x|
				if char == "S"
					s_x = x
					s_y = y
					break
				end
			end
			break if s_x != -1
		end

		s = find_start_symbol(grid, s_x, s_y)
		grid[s_y].sub!("S", s)

		return [s_x, s_y]
	end

	def self.find_start_symbol(grid, s_x, s_y)
		r = ""
		[[1, 0], [0, 1], [-1, 0], [0, -1]].each do |dx, dy|
			nx = s_x+dx
			ny = s_y+dy
			next unless CONNECTS[[dx, dy]].include?(grid[ny][nx])
			r += dx.to_s + dy.to_s
		end

		translate = {
			"10-10" => "-",
			"100-1" => "L",
			"1001" => "F",
			"010-1" => "|",
			"01-10" => "7",
			"-100-1" => "J"
		}
		return translate[r]
	end
end

Day10.run
