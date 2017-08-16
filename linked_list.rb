
# Defines a node in the singly linked list
class Node
  attr_reader :data # allow external entities to read value but not write
  attr_accessor :next # allow external entities to read or write next node

  def initialize(value)
    @data = value
    @next = nil
  end
end

# Defines the singly linked list
class LinkedList
  def initialize
    @head = nil # keep the head private. Not accessible outside this class
  end

  # method to add a new node with the specific data value in the linked list
  # insert the new node at the beginning of the linked list
  def insert(value)
    new_node = Node.new(value)

    if @head != nil # if linked list is not empty
      new_node.next = @head
    end

    @head = new_node
  end

  # method to find if the linked list contains a node with specified value
  # returns true if found, false otherwise
  def search(value)
    current = @head
    while current != nil
      if current.data == value
        return true
      end
      current = current.next
    end

    return false
  end

  # method to return the max value in the linked list
  # returns the data value and not the node
  def find_max
    if @head == nil # empty list case
      puts "Error: The linked list is empty. Cannot compute max."
      return nil
    end

    current = @head
    max = current.data
    current = current.next
    while current != nil
      if current.data > max
        max = current.data
      end
      current = current.next
    end
    return max
  end

  # method to return the min value in the linked list
  # returns the data value and not the node
  def find_min
    if @head == nil # empty list case
      puts "Error: The linked list is empty. Cannot compute min."
      return nil
    end

    current = @head
    min = current.data
    current = current.next
    while current != nil
      if current.data < min
        min = current.data
      end
      current = current.next
    end
    return min
  end

  # method that returns the length of the singly linked list
  def length
    count = 0
    current = @head
    while current != nil
      count += 1
      current = current.next
    end

    return count
  end

  # method to return the value of the nth element from the beginning
  # assume indexing starts at 0 while counting to n
  def find_nth_from_beginning(n)
    index = 0
    current = @head
    while current != nil
      if index == n
        return current.data
      end
      current = current.next
      index += 1
    end
    puts "Error: #{n} exceeds the linked list length."
    return nil
  end

  # method to insert a new node with specific data value, assuming the linked
  # list is sorted in ascending order
  def insert_ascending(value)
    new_node = Node.new(value)

    # check for new_node being the new head case
    if @head == nil || value <= @head.data
      new_node.next = @head
      @head = new_node
      return
    end

    current = @head
    while current.next != nil && current.next.data < value
      current = current.next
    end
    new_node.next = current.next
    current.next = new_node
  end

  # method to print all the values in the linked list
  def visit
    current = @head
    while current != nil
      print "#{current.data} "
      current = current.next
    end
    puts
  end

  # method to delete the first node found with specified value
  def delete(value)
    if @head == nil
      return
    end

    # account for case: node to delete is current head
    if @head.data == value
      @head = @head.next
      return
    end

    current = @head
    while current.next != nil
      if current.next.data == value
        current.next = current.next.next
        return
      end
      current = current.next
    end
    # value to be deleted was not found if the control flow reaches here
  end

  # method to reverse the singly linked list
  # note: the nodes should be moved and not just the values in the nodes
  def reverse
    current = @head
    previous = nil
    while current != nil
      temp = current.next # save state
      current.next = previous # update link

      # move to next
      previous = current
      current = temp
    end
    @head = previous
  end

  ## Advanced Exercises
  # returns the value at the middle element in the singly linked list
  def find_middle_value
    if @head == nil
      return nil
    end

    slow = @head
    fast = @head.next
    while fast != nil
      slow = slow.next
      fast = fast.next
      if fast != nil
        fast = fast.next
      end
    end
    return slow.data
  end

  # find the nth node from the end and return its value
  # assume indexing starts at 0 while counting to n
  def find_nth_from_end(n)
    # approach with going through the linked list just once
    current = @head
    index = 0
    # count to n from the beginning
    while current != nil && index != n
      current = current.next
      index += 1
    end

    # check that we didn't reach the end
    if current == nil
      puts "Error: The linked list has less than #{n} indexable nodes"
      return
    end

    # the previous while loop exited because of index == n condition
    # start a new traverser at the beginning.
    # when current reaches the end, new_current will be at index n from the end
    new_current = @head
    while current.next != nil
      current = current.next
      new_current = new_current.next
    end
    return new_current.data
  end

  # checks if the linked list has a cycle. A cycle exists if any node in the
  # linked list links to a node already visited.
  # returns true if a cycle is found, false otherwise.
  def has_cycle
    if @head == nil || @head.next == nil
      return false
    end
    slow = @head
    fast = @head
    while fast != nil
      slow = slow.next
      fast = fast.next
      if fast != nil
        fast = fast.next
      end
      if slow == fast
        return true # cycle detected
      end
    end
    return false # reached the end of the linked list - no cycle detected
  end

  # Creates a cycle in the linked list for testing purposes
  # Assumes the linked list has at least one node
  def create_cycle
    return if @head == nil # don't do anything if the linked list is empty

    # navigate to last node
    current = @head
    while current.next != nil
      current = current.next
    end

    current.next = @head # make the last node link to first node
  end
end

## --- END of class definitions --- ##

# Create an object of linked list class
my_linked_list = LinkedList.new()

# Add some values to the linked list
puts "Adding 5, 3 and 1 to the linked list."
my_linked_list.insert(5)
my_linked_list.insert(3)
my_linked_list.insert(1)

# print all elements
puts "Printing elements in the linked list:"
my_linked_list.visit

# Find the value at the nth node
puts "Confirming values in the linked list using find_nth_from_beginning method."
value = my_linked_list.find_nth_from_beginning(2)
puts "BUG: Value at index 2 should be 5 and is #{value}" if value != 5
value = my_linked_list.find_nth_from_beginning(1)
puts "BUG: Value at index 1 should be 3 and is #{value}" if value != 3
value = my_linked_list.find_nth_from_beginning(0)
puts "BUG: Value at index 0 should be 1 and is #{value}" if value != 1

# print all elements
puts "Printing elements in the linked list:"
my_linked_list.visit

# Insert ascending
puts "Adding 4 in ascending order."
my_linked_list.insert_ascending(4)
# check newly inserted value
puts "Checking values by calling find_nth_from_beginning method."
value = my_linked_list.find_nth_from_beginning(2)
puts "BUG: Value at index 2 should be 4 and is #{value}" if value != 4
value = my_linked_list.find_nth_from_beginning(3)
puts "BUG: Value at index 3 should be 5 and is #{value}" if value != 5
value = my_linked_list.find_nth_from_beginning(1)
puts "BUG: Value at index 1 should be 3 and is #{value}" if value != 3

# Insert ascending
puts "Adding 6 in ascening order."
my_linked_list.insert_ascending(6)

# print all elements
puts "Printing elements in the linked list:"
my_linked_list.visit

# vaidate length
puts "Confirming length of the linked list."
my_linked_list_length = my_linked_list.length
puts "BUG: Length should be 5 and not #{my_linked_list_length}" if my_linked_list_length != 5

# find min and max
puts "Confirming min and max values in the linked list."
min = my_linked_list.find_min
puts "BUG: Min value should be 1 and not #{min}" if min != 1
max = my_linked_list.find_max
puts "BUG: Max value should be 5 and not #{max}" if max != 6

# delete value
puts "Deleting node with value 5 from the linked list."
my_linked_list.delete(5)
# print all elements
puts "Printing elements in the linked list:"
my_linked_list.visit
# validate length
puts "Confirming length of the linked list."
my_linked_list_length = my_linked_list.length
puts "BUG: Length should be 4 and not #{my_linked_list_length}" if my_linked_list_length != 4

# delete value
puts "Deleting node with value 1 from the linked list."
my_linked_list.delete(1)
# print all elements
puts "Printing elements in the linked list:"
my_linked_list.visit
# validate length
puts "Confirming length of the linked list."
my_linked_list_length = my_linked_list.length
puts "BUG: Length should be 3 and not #{my_linked_list_length}" if my_linked_list_length != 3

# find middle element
puts "Confirming middle value in the linked list."
middle = my_linked_list.find_middle_value
puts "BUG: Middle value should be 4 and not #{middle}" if middle != 4

# reverse the linked list
puts "Reversing the linked list."
my_linked_list.reverse
# print all elements
puts "Printing elements in the linked list:"
my_linked_list.visit
# verify the reversed list
puts "Verifying the reveresed linked list by calling find_nth_from_beginning method."
value = my_linked_list.find_nth_from_beginning(2)
puts "BUG: Value at index 2 should be 3 and is #{value}" if value != 3
value = my_linked_list.find_nth_from_beginning(1)
puts "BUG: Value at index 1 should be 4 and is #{value}" if value != 4
value = my_linked_list.find_nth_from_beginning(0)
puts "BUG: Value at index 0 should be 6 and is #{value}" if value != 6

# nth from the end
puts "Verifying find_nth_from_end method."
value = my_linked_list.find_nth_from_end(0)
puts "BUG: Value at index 0 from the end, should be 3 and is #{value}" if value != 3
value = my_linked_list.find_nth_from_end(1)
puts "BUG: Value at index 1 from the end, should be 4 and is #{value}" if value != 4
value = my_linked_list.find_nth_from_end(2)
puts "BUG: Value at index 2 from the end, should be 6 and is #{value}" if value != 6

# check for cycle
puts "Checking the linked list for cycle."
puts "BUG: Should not have a cycle." if my_linked_list.has_cycle

# create cycle and then test for it
puts "Creating a cycle in the linked list."
my_linked_list.create_cycle
puts "Checking the linked list for cycle."
puts "BUG: Should not have a cycle." if !(my_linked_list.has_cycle)
