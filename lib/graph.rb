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
    raise "Can you please add the nodes #{node1} and #{node2} first" unless valid_node?(node1) && valid_node?(node2)
    @edges << Edge.new(from: node1, to: node2, value: params[:value])
  end

  def == other
    nodes == other.nodes && edges == other.edges
  end

  private

  def valid_node? to_validate_node
    !!nodes.find { |node| node == Node.new(to_validate_node) }
  end

end
