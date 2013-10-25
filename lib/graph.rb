class Graph
  attr_reader :nodes, :vertices

  def initialize
    @nodes = []
    @vertices = []
  end

  def add_node name
    !!(@nodes << name)
  end

  def connect *args
    node1, node2, params = args
    @vertices = {
      "#{node1}-#{node2}" => args
    }
  end
end
