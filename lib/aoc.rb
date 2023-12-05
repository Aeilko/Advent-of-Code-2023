require 'open-uri'

# TODO: Overwrite Array's to_s method, cause the default `puts Array` output sucks

module AOC

	YEAR = 2023

	module Day
		# Settings
		attr_accessor :num, :ans_test1, :ans_test2

		# Instance variables
		attr_accessor :input, :test_input, :test_input1, :test_input2

		def run
			attr_defaults
			puts "--- Running day #{@num} ---".yellow

			load_inputs

			if @input.nil?
				puts "Input is missing".red
				return
			end

			run_part 1
			run_part 2
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
			if @test_input.nil? and not (@ans_test1.nil? and @ans_test2.nil?)
				# TODO: Allow part 1 and 2 to have different test inputs
				# Load test input of this day
				path = "inputs/test/test_input%02d" % @num
				if File.exist?(path)
					@test_input = File.read(path)
				end
			end
		end

		def run_part(part)
			# TODO: add the option to track the runtime of a solution
			puts "--- Part #{part} ---".yellow

			# Check if the solve_partX method is implemented
			unless self.respond_to?("solve_part#{part}")
				puts "This part has not been implemented".red
				return
			end

			# Run test if configured
			ans_test = self.send("ans_test#{part}")
			if not ans_test.nil? and not @test_input.nil?
				test = self.send("solve_part#{part}", @test_input)

				if test != ans_test
					puts "Test failed, result '#{test}', expected '#{ans_test}'".red
					return
				end

				puts "Test successful".green
			end

			# Solve this part
			result = self.send("solve_part#{part}", @input)
			puts "Result: #{result}"
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
