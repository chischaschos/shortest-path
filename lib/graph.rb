class Graph
  attr_reader :nodes, :vertices

  def initialize
    @nodes = []
    @vertices = []
  end

  def add_node name
    !!(@nodes << Node.new(name))
  end

  def connect *args
    node1, node2, params = args
    @vertices << Vertice.new(from: node1, to: node2, value: params[:value])
  end
end
