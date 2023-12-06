require_relative '../lib/aoc'

module Day06
	extend AOC::Day

	@num = 6
	@ans_test1 = 288
	@ans_test2 = 71503

	def self.solve_part1(input)
		r = []
		time = input.lines[0].scan(/\d+/).map(&:to_i)
		distance = input.lines[1].scan(/\d+/).map(&:to_i)
		(0...time.length).each do |i|
			s = 0
			(1...time[i]).each do |j|
				s += 1 if (time[i]-j)*j > distance[i]
			end
			r << s
		end
		return r.inject(:*)
	end

	def self.solve_part2_old(input)
		start_time = Time.now
		r = 0

		time = input.lines[0].scan(/\d+/).join("").to_i
		distance = input.lines[1].scan(/\d+/).join("").to_i
		(1...time).each do |i|
			r += 1 if (time-i)*i > distance
		end
		time = Time.now-start_time
		puts "Runtime: #{time}s"
		return r
	end

	def self.solve_part2(input)
		time = input.lines[0].scan(/\d+/).join("").to_i
		distance = input.lines[1].scan(/\d+/).join("").to_i

		# distance = time*x - x^2 => x^2 - time*x + distance = 0
		b = time*-1
		c = distance
		x1 = (((b*-1) - Math.sqrt(b**2 - (4*c)))/2).ceil
		x2 = (((b*-1) + Math.sqrt(b**2 - (4*c)))/2).ceil
		return x2-x1
	end
end

Day06.run
