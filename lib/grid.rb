module Grid
	def self.string_to_grid(inp)
		return inp.lines.map{ |line| line.strip }
	end

	def self.get_neighbours(grid, x, y, include_coords = false)
		r = []

		my = grid.length-1
		mx = grid[0].length-1
		[[-1, -1], [0, -1], [1, -1], [-1, 0], [1, 0], [-1, 1], [0, 1], [1, 1]].each do |dx, dy|
			next if !(x+dx).between?(0, mx) or !(y+dy).between?(0, my)
			if include_coords
				r << [grid[y+dy][x+dx], [x+dx, y+dy]]
			else
				r << grid[y+dy][x+dx]
			end

		end

		r
	end
end
