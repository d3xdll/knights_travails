class Knight
  def initialize(start, finish)
    @start = start
    @finish = finish
    #possible moves of knight
    @x = [2, 1, -1, -2, -2, -1, 1, 2]
    @y = [1, 2, 2, 1, -1, -2, -2, -1]
    @start_node = Node.new(@start)
    @finish_node = Node.new(@finish)
    @@visited = [@start_node]
  end
  
  # def generate_children(node = @start_node, end_node = nil)
  #   return @start_node.children if node.value = @finish

  #   @x.each_with_index do |num, index|
  #     x = num + node.value[0]
  #     y = @y[index] + node.value[1]
  #     if [x, y] == @finish
  #       node.children = nil
  #     elsif valid?([x, y])
  #       @@visited << [x, y]
  #       new_node = Node.new([x, y])
  #       node.children << new_node
  #       end_node == new_node
  #     end
  #   end
  #   node.children.each do |child|
  #     generate_children(child)
  #   end
  #   @start_node
  # end

  # def create_graph(root = generate_children.children)
  #   arr = []
  #   root.each do |n|
  #     arr << n
  #   end
  #   unless arr.empty?
  #     current = arr.shift
  #     if current.value == @finish
  #       p "yay that finish #{current}"
  #     end
  #   end
  # end


  def generate_moves(coord = @start_node.value)
    visited = []
    queue = []
    queue.push(@start_node)
    visited << coord
    current = @start_node
    until current == @finish || queue.empty?
      "Queue is #{queue}"
      current = queue.shift
      @x.each_with_index do |num, index|
        x = num + current.value[0]
        y = @y[index] + current.value[1]
        if [x, y] == @finish
          finish_node = Node.new([x, y])
          current.children << finish_node
          break
        elsif valid?([x, y]) && visited.none?([x, y])
          node = Node.new([x, y])
          current.children << node
          queue.push(node)
          visited << [x, y]
        end
      end
    end
    @start_node
  end

  def node_search
    node = generate_moves
    queue = []
    node.children.each do |n|
      p "node is #{n.children}"
    end
  end

  def valid?(coord)
    unless @@visited.include?(coord)
      coord[0] >= 0 && coord[0] < 8 && coord[1] >= 0 && coord[1] < 8 ? true : false
    end
  end
end



class Node
  attr_accessor :value, :children

  def initialize(value)
    @value = value
    @children = []
  end

end

new_knight = Knight.new([0, 0], [2, 2])
new_knight.generate_moves
new_knight.node_search