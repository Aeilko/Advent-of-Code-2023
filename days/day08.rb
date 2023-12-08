require_relative '../lib/aoc'
require_relative '../lib/binary_tree'

module Day08
	extend AOC::Day

	@num = 8
	@ans_test1 = 2
	@ans_test2 = 6

	def self.solve_part1(input)
		tree = BinaryTree::Tree.new("AAA")

		input.lines[2..-1].each do |line|
			val, left, right = line.scan /[A-Z\d]{3}/
			tree.node(val, left, right)
		end

		commands = input.lines[0].strip

		r = 0
		cur_node = tree.root
		while true
			break if cur_node.value == "ZZZ"
			cur_node = (commands[r%commands.length] == "L" ? cur_node.left : cur_node.right)
			r += 1
		end
		return r
	end

	def self.solve_part2(input)
		tree = BinaryTree::Tree.new("AAA")

		start_nodes = []
		input.lines[2..-1].each do |line|
			val, left, right = line.scan /[\dA-Z]{3}/
			n = tree.node(val, left, right)
			if val[2] == "A"
				start_nodes << n
			end
		end

		commands = input.lines[0].strip
		cycles = []
		start_nodes.each do |n|
			r = 0
			cur_node = n
			while true
				break if cur_node.value[2] == "Z"
				cur_node = (commands[r%commands.length] == "L" ? cur_node.left : cur_node.right)
				r += 1
			end
			cycles << r
		end

		return cycles.reduce(1, :lcm)
	end
end

Day08.run
