class Knight
  def initialize(start, finish)
    @start = start
    @finish = finish
    #possible moves of knight
    @x = [2, 1, -1, -2, -2, -1, 1, 2]
    @y = [1, 2, 2, 1, -1, -2, -2, -1]
  end

  def generate_moves(coord)
    moves = []
    visited = []
    visited << coord
    @x.each_with_index do |num, index|
      x = num + coord[0]
      y = @y[index] + coord[1]
      if valid?([x, y]) && visited.none?([x, y])
        visited << [x, y]
        moves << [x, y]
      end
    end
    moves
  end
  
  def make_graph
    queue = [Node.new(@start)]
    current = queue.shift
    until current.value == @finish
      move = generate_moves(current.value)
      move.each do |n|
        node = Node.new(n, current)
        queue << node
        current.children << node
      end
      current = queue.shift
    end
    current
  end

  def moves_history(current, history = [])
    until current.value == @start
      history << current
      current = current.parent
    end
    history << current
    history
  end

  def path(path)
    path.each {|n| p n.value}
  end

  def knight_move
    finish_line = make_graph
    history = moves_history(finish_line)
    path(history.reverse)
  end

  def valid?(coord)
    coord[0] >= 0 && coord[0] < 8 && coord[1] >= 0 && coord[1] < 8 ? true : false
  end
end

class Node
  attr_accessor :value, :children, :parent

  def initialize(value, parent = nil)
    @value = value
    @parent = parent
    @children = []
  end

end

new_knight = Knight.new([0, 0], [7, 7])
new_knight.knight_move