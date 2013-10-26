class Graph
  attr_reader :nodes, :edges

  def initialize
    @nodes = []
    @edges = []
  end

  def add_node name
    !!(@nodes << Node.new(name))
  end

  def connect *args
    node1, node2, params = args
    @edges << Edge.new(from: node1, to: node2, value: params[:value])
  end

  def == other
    nodes == other.nodes && edges == other.edges
  end
end
