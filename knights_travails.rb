class Board
    attr_accessor :squares, :knight
    
    def initialize
        @squares = Array.new
        build_board(8)
        @knight = Knight.new([1,1])
    end
    
    def build_board(x)
        (1..x).each do |y|
            (1..x).each do |z|
                @squares << [y, z]
            end
        end
    end
end

class Knight
    attr_accessor :path, :position, :possible_moves
    
    def initialize(position)
        @position = position
        @possible_moves = Array.new
    end
    
    def find_possible_moves(position)
        possible_moves = Array.new
        position_node = Node.new(position)
        position_node.children.each do |child|
            possible_moves << child
        end
        @possible_moves = possible_moves
    end

    def knight_moves(start_value, target)
        start = Node.new(start_value, nil)
        queue = Array.new
        queue << start
        target_node = nil
        found = false
        nodes_visited = Array.new
        until found
            current_node = queue.shift
            nodes_visited << current_node
            current_node.children.each do |child_value|
                child = Node.new(child_value, current_node)
                if child.value == target
                    found = true
                    target_node = child
                else
                    queue << child
                end
            end
        end
        output_path(target_node)
    end
    
    def output_path(node)
        path = Array.new
        path << node.value
        until node.parent.nil?
            temp = node.parent
            node = temp
            path.unshift(node.value)
        end
        puts "The from #{path[-1]} to #{path[0]} is:"
        path.each do |square|
            puts square.inspect
        end
    end
        
end
    
class Node
    attr_accessor :value, :children, :parent
    def initialize(value, parent=nil)
        @parent = parent
        @value = value
        @children = Array.new
        find_children
    end
    
    def find_children
        right_edges
        left_edges
        top_edges
        bottom_edges
    end

    def right_edges
        zero_plus_two = @value[0] + 2
        one_plus_one = @value[1] + 1
        one_minus_one = @value[1] - 1
        
        if zero_plus_two <= 8
            if one_plus_one <= 8
                @children << [zero_plus_two, one_plus_one]
            end
            if one_minus_one >= 1
                @children << [zero_plus_two, one_minus_one]
            end
        end
    end
    
    def left_edges
        zero_minus_two = @value[0] - 2
        one_plus_one = @value[1] + 1
        one_minus_one = @value[1] - 1
        
        
        if zero_minus_two >= 1
            if one_plus_one <= 8
                @children << [zero_minus_two, one_plus_one]
            end
            if one_minus_one >= 1
                @children << [zero_minus_two, one_minus_one]
            end
        end
    end
    
    def top_edges
        one_plus_two = @value[1] + 2
        zero_plus_one = @value[0] + 1
        zero_minus_one = @value[0] - 1
        
        if one_plus_two <= 8
            if zero_plus_one <= 8
                @children << [zero_plus_one, one_plus_two]
            end
            if zero_minus_one >= 1
                @children << [zero_minus_one, one_plus_two]
            end
        end
    end
    
    def bottom_edges
        one_minus_two = @value[1] - 2
        zero_plus_one = @value[0] + 1
        zero_minus_one = @value[0] - 1

        if one_minus_two >= 1
            if zero_plus_one <= 8
                @children << [zero_plus_one, one_minus_two]
            end
            if zero_minus_one >= 1
                @children << [zero_minus_one, one_minus_two]
            end
        end
    end
end



my_board = Board.new
knight = my_board.knight
knight.knight_moves([3,3], [4,3])