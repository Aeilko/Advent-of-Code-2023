require 'open-uri'

module AOC

	YEAR = 2023

	module Day
		# Settings
		attr_accessor :num, :ans_test1, :ans_test2

		# Instance variables
		attr_accessor :input, :test_input, :test_input1, :test_input2

		def run(track_runtime = false)
			attr_defaults
			puts "--- Running day #{@num} ---".yellow

			load_inputs

			if @input.nil?
				puts "Input is missing".red
				return
			end

			run_part 1, track_runtime
			run_part 2, track_runtime
		end

		def load_inputs
			# Load inputs
			if @input.nil?
				# Load actual input of this day
				path = "inputs/input%02d" % @num
				unless File.exist?(path)
					return unless AOC::Net.configured? and @num != 0
					AOC::Net.retrieve_input @num
				end
				@input = File.read(path)
			end
			if not (@ans_test1.nil? and @ans_test2.nil?) and (@test_input1.nil? or @test_input2.nil?)
				# Load test input of this day
				path = "inputs/test/test_input%02d" % @num
				if File.exist?(path) and @test_input.nil?
					@test_input = File.read(path)
				end

				if @test_input1.nil?
					p1_path = path + "_p1"
					if File.exist?(p1_path)
						@test_input1 = File.read(p1_path)
					elsif not @test_input.nil?
						@test_input1 = @test_input
					end
				end
				if @test_input2.nil?
					p2_path = path + "_p2"
					if File.exist?(p2_path)
						@test_input2 = File.read(p2_path)
					elsif not @test_input.nil?
						@test_input2 = @test_input
					end
				end
			end
		end

		def run_part(part, track_runtime = false)
			puts "--- Part #{part} ---".yellow

			# Check if the solve_partX method is implemented
			unless self.respond_to?("solve_part#{part}")
				puts "This part has not been implemented".red
				return
			end

			# Run test if configured
			ans_test = self.send("ans_test#{part}")
			inp_test = self.send("test_input#{part}")
			unless ans_test.nil? or inp_test.nil?
				test = self.send("solve_part#{part}", inp_test)

				if test != ans_test
					puts "Test failed, result '#{test}', expected '#{ans_test}'".red
					return
				end

				puts "Test successful".green
			end

			# Solve this part
			start = Time.now
			result = self.send("solve_part#{part}", @input)
			stop = Time.now

			puts "Result: #{result}#{(track_runtime ? "\t\t(Runtime: #{stop-start}s)" : "")}"
		end

		def attr_defaults
			@num = 0 if @num.nil?
		end
	end

	module Net
		@base_url = "https://adventofcode.com"

		def self.configured?
			if @session.nil? and File.exist?("session")
				@session = File.read("session")
			end
			return !@session.nil?
		end

		def self.retrieve_input(day)
			return unless configured?

			puts "Downloading input file..."

			local_path = "inputs/input%02d" % day

			url = "#{@base_url}/#{AOC::YEAR}/day/#{day}/input"
			headers = [
				"User-Agent" => "https://github.com/Aeilko/Advent-of-Code-#{AOC::YEAR}",
				"Cookie" => "session=#{@session}",
			]

			content = URI.open(url, *headers).read
			File.write(local_path, content, mode: "w")

			content
		end
	end
end

class String
	def red;	"\e[31m#{self}\e[0m" end
	def green;	"\e[32m#{self}\e[0m" end
	def yellow;	"\e[33;1m#{self}\e[0m" end
end
