class BinaryTree
    attr_accessor :root, :tree
    
    class Node
        attr_accessor :root, :left, :right, :value
        
        def initialize(value)
            @value = value
            @root = nil
            @left = nil
            @right = nil
        end
        
        def get_value(location, value)
            case location
            when "root" then @root = value
            when "right" then @right = value
            when "left" then @left = value
            end
        end
        
        def set_value(location, value)
            case location
            when "root" then @root = value
            when "right" then @right = value
            when "left" then @left = value
            end
        end
    end
    
    def initialize(array)
        @root = Node.new(array[array.length/2])
        @tree = Array.new
        @tree << @root
        build_array(array)
        puts inorder_search(@root)
        puts level_order_traverse(@root)
    end
    
    def build_array(array)
        array.each do |value|
            node = Node.new(value)
            root = @root
            leaf_node = false
            next if node.value == root.value
            until leaf_node
                if (node.value < root.value) && root.left.nil?
                    root.left = node
                    node.root = root
                    leaf_node = true
                elsif (node.value > root.value) && root.right.nil?
                    root.right = node
                    node.root = root
                    leaf_node = true
                else
                    if (node.value < root.value) && (node.value > root.left.value)
                        if root.left.right.nil?
                            root.left.right = node
                            node.root = root.left
                            leaf_node = true
                        else
                            root = root.left
                        end
                    elsif (node.value > root.value) && (node.value < root.right.value)
                        if root.right.left.nil?
                            root.right.left = node
                            node.root = root.right
                            leaf_node = true
                        else
                            root = root.right
                        end
                    else
                        if node.value < root.value 
                            root = root.left
                        elsif node.value > root.value
                            root = root.right
                        elsif node.value == root.value
                            leaf_node = true
                        end
                    end
                end
            end
            @tree << node
        end
    end
    
    def inorder_search(root)
        return if root.nil?
        inorder_search(root.left)
        print " #{root.value} "
        inorder_search(root.right)
    end
    
    def dfs_rec_call(value)
        dfs_rec(@root, value)
    end
    
    def dfs_rec(node, target)
        return nil if node.nil?
        return node if node.value == target
        
        left_search = dfs_rec(node.left, target)
        return left_search unless left_search.nil?
        right_search = dfs_rec(node.right, target)
        return right_search unless right_search.nil?
        
    end
    
    def depth_first_search(value)
        root = @root
        queue = Array.new
        queue << root
        return_value = nil
        found = false
        until found
            current_node = queue.pop
            unless current_node.right.nil?
                queue << current_node.right
            end
            unless current_node.left.nil? 
                queue << current_node.left
            end
            if current_node.value == value
                return_value = current_node
                found = true
            elsif queue.empty?
                return_value = nil
                found = true
            end
        end
        puts "No such value was found" if return_value.nil?
        return_value
    end
    
    def breadth_first_search(value)
        root = @root
        queue = Array.new
        queue << root
        return_value = nil
        found = false
        until found
            current_node = queue.shift
            unless current_node.left.nil?
                queue << current_node.left
            end
            unless current_node.right.nil? 
                queue << current_node.right
            end
            if current_node.value == value
                return_value = current_node
                found = true
            elsif queue.empty?
                return_value = nil
                found = true
            end
        end
        puts "No such value was found" if return_value.nil?
        return_value
    end
    
    def level_order_traverse(root)
        queue = Array.new
        queue << root
        return_value = ""
        until queue.empty?
            current_node = queue.shift
            unless current_node.left.nil?
                queue << current_node.left
            end
            unless current_node.right.nil? 
                queue << current_node.right
            end
            return_value += " #{current_node.value.to_s} "
        end
        return_value
    end
        
        
end

test_array = [1, 7, 4, 29, 57, 2, 20, 21, 23, 67, 6345, 324].to_a
alt_test = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324].sort.to_a

test3 = [1,7,4,23,8,9,4,3,5,7,9,67,6345,324].to_a
my_tree = BinaryTree.new(test_array)
my_tree1 = BinaryTree.new(test3)
puts my_tree.breadth_first_search(23)
puts my_tree.depth_first_search(23)
puts my_tree.dfs_rec_call(23)