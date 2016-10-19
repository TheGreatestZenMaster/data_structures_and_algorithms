class LinkedList
    attr_accessor :size
    
    class Node
        attr_accessor :next, :value
        def initialize(value)
            @value = value
            @next = nil
        end
    end

    def initialize
        @size = 0
        @head = nil
        @tail = nil
    end
    
    def head
        @head.value
    end
    
    def tail
        @tail.value
    end
    
    def size
        @size
    end
    
    def prepend(value)
        new_node = Node.new(value)
        if @head == nil
            @head = new_node
            @tail = new_node
        else
            tmp = @head
            @head = new_node
            @head.next = tmp
        end
        @size += 1
    end
    
    def append(value)
        new_node = Node.new(value)
        if @tail == nil
            @head = new_node
            @tail = new_node
        else
            @tail.next = new_node
            @tail = new_node
        end
        @size += 1
    end
    
    def at_index(index)
        count = 1
        node_at_index = @head
        node = @head
        until count == index
            node = node.next
            count += 1
            if count == index
                node_at_index = node
            end
        end
        node_at_index.value
    end
    
    def pop
        if @size == 0
            puts "There are no elements in the list"
        elsif @size == 1
            @head = nil
            @tail = nil
            puts "Element popped"
            @size -= 1
        else
            node = @head
            while true
                if node.next == @tail
                    @tail = node
                    node.next = nil
                    @size -= 1
                    break
                else
                    node = node.next
                end
            end
            puts "Last element popped!"
        end
    end
    
    def find_index(value)
        count = 1
        index_at_value = 0
        node = @head
        while true
            if node.value == value
                index_at_value = count
                break
            else
                node = node.next
                count += 1
            end
        end
        (index_at_value == 0)? (puts "No such value"): index_at_value
    end
    
    def insert_at(value, index)
        if index > @size || index < 0
            puts "That is not a valid index"
        else
            new_node = Node.new(value)
            count = 1
            node = @head
            while true
                if (count + 1) == index
                    temp = node.next
                    node.next = new_node
                    new_node.next = temp
                    @size += 1
                    puts "Node inserted at #{index}"
                    break
                else
                    node = node.next
                    count += 1
                end
            end
        end
    end
    
    def remove_at(index)
        if index > @size || index < 0
            puts "That is not a valid index"
        else
            count = 1
            node = @head
            while true
                if (count + 1) == index
                    node.next = node.next.next
                    @size -= 1
                    puts "Node revemoved at #{index}"
                    break
                else
                    node = node.next
                    count += 1
                end
            end
        end
    end
    
    def contains?(value)
        contains_value = false
        node = @head
        while true
            if value == node.value
                contains_value = true
                break
            else
                (node.next == nil)? break: node = node.next
            end
        end
        (contains_value)? (puts "That value exists in the array"): (puts "No such value")
    end
    
    def to_string
        data = ''
        node = @head
        while true
            data << "( #{node.value} ) -> "
            if node.next == nil
                data << "nil"
                break
            else
                node = node.next
            end
        end
        data
    end
end

my_linked_list = LinkedList.new
my_linked_list.append(10)
my_linked_list.append(11)
my_linked_list.append(12)
my_linked_list.append(13)
my_linked_list.prepend(9)
puts my_linked_list.head
puts my_linked_list.tail
puts my_linked_list.to_string
puts my_linked_list.at_index(2)
my_linked_list.pop
puts my_linked_list.to_string
puts my_linked_list.size
puts my_linked_list.find_index(9)
my_linked_list.contains?(9)
my_linked_list.insert_at(9.5, 2)
puts my_linked_list.to_string
my_linked_list.remove_at(2)
puts my_linked_list.to_string