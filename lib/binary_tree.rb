module BinaryTree

	class Tree
		attr_reader :root

		def initialize(root_val)
			@root = Node.new(root_val)
			@nodes = {
				root_val => @root
			}
		end

		def node(val, left=nil, right=nil)
			return val if val.class == Node

			n = @nodes[val]
			unless n
				n = Node.new(val)
				@nodes[val] = n
			end
			n.left = node(left) unless left.nil?
			n.right = node(right) unless right.nil?
			n
		end
	end

	class Node
		attr_reader :value
		attr_accessor :left, :right

		def initialize(val)
			@value = val
		end

		def add_left(val)
			n = Node.new val
			@left = n
			n
		end

		def add_right(val)
			n = Node.new val
			@right = n
			n
		end
	end
end