require_relative '../lib/aoc'
require_relative '../lib/grid'

module Day03
	extend AOC::Day

	@num = 3
	@ans_test1 = 4361
	@ans_test2 = 467835

	def self.solve_part1(input)
		r = 0
		grid = Grid::string_to_grid(input)

		(0...grid.length).each do | y |
			cur_num = nil
			cur_icon = false
			(0...grid[0].length).each do | x |
				c = grid[y][x]
				if c =~ /\d/
					cur_num = cur_num.nil? ? c.to_i : cur_num*10 + c.to_i

					unless cur_icon
						n = Grid::get_neighbours(grid, x, y)
						cur_icon = n.any?{ |char| char =~ /[^\d.]/ }
					end
				else
					unless cur_num.nil?
						r += cur_num if cur_icon
						cur_num = nil
						cur_icon = false
					end
				end
			end
			r += cur_num if cur_icon
		end

		r
	end

	def self.solve_part2(input)
		r = 0
		grid = Grid::string_to_grid(input)

		gears = {}
		(0...grid.length).each do | y |
			cur_gears = []
			cur_num = nil
			(0...grid[0].length).each do | x |
				c = grid[y][x]
				if c =~ /\d/
					cur_num = cur_num.nil? ? c.to_i : cur_num*10 + c.to_i

					n = Grid::get_neighbours(grid, x, y, true)
					n.select{|nc, _| nc == "*" }.each do |_, coord|
						coord_string = "#{coord[0]},#{coord[1]}"
						cur_gears << coord_string unless cur_gears.include?(coord_string)
					end
				else
					unless cur_num.nil?
						cur_gears.each do |coords|
							if gears.key?(coords)
								gears[coords].append(cur_num)
							else
								gears[coords] = [cur_num]
							end
						end
						cur_gears = []
						cur_num = nil
					end
				end
			end
			unless cur_num.nil?
				cur_gears.each do |coords|
					if gears.key?(coords)
						gears[coords].append(cur_num)
					else
						gears[coords] = [cur_num]
					end
				end
			end
		end

		gears.each do |_, nums|
			r += nums[0]*nums[1] if nums.length == 2
		end

		r
	end
end

Day03.run
