require_relative '../lib/aoc'

module Day05
	extend AOC::Day

	@num = 5
	@ans_test1 = 35
	@ans_test2 = 46

	def self.solve_part1(input)
		groups = input.split("\n\n")

		nums = groups[0].scan(/\d+/).map(&:to_i)

		groups[1..-1].each do |group|
			new_nums = []

			lines = group.lines
			lines[1..-1].each do |line|
				dest, source, length = line.scan(/\d+/).map(&:to_i)
				nums.delete_if do |n|
					if n.between?(source, source+length-1)
						new_nums << (n-source)+dest
						true
					end
				end
			end
			nums += new_nums
		end
		return nums.min
	end

	def self.solve_part2(input)
		# Changing part 1 to ranges instead of nums would the correct way of doing this.
		# But simply running part 1 bottom up also works, and is way easier, it just takes some time
		groups = input.split("\n\n")

		seeds_nums = groups[0].scan(/\d+/).map(&:to_i)
		seeds = []
		(0...seeds_nums.length/2).each do |i|
			start = seeds_nums[i*2]
			stop = start+seeds_nums[(i*2)+1]-1
			seeds << [start, stop]
		end

		groups = groups[1..-1].map{ |group| group.lines[1..-1].map{|line| line.scan(/\d+/).map(&:to_i) } }
		i = 0
		start_time = Time.now
		while true
			num = i
			groups.reverse_each do |group|
				group.each do |source, dest, length|
					if num.between?(source, source+length-1)
						num = (num-source)+dest
						break
					end
				end
			end

			seeds.each do |start, stop|
				if num.between?(start, stop)
					puts "Runtime: #{(Time.now-start_time).round}s"
					return i
				end
			end

			i += 1
		end
	end
end

Day05.run
