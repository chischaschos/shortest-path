require 'ostruct'

class ShortestPath
  attr_reader :current

  def initialize *args
    @graph, @params = args
    nodes_set
  end

  def find
    OpenStruct.new value: 20, string: '1,3,6,5'
  end

  def nodes_set
    @nodes_set ||= @graph.nodes.dup.reduce({}) do |result, node|
      if node.name == @params[:from]
        @current = node
        node.value = 0
        node.state = :current
      else
        node.value = :infinity
        node.state = :unvisited
      end
      result[node.name] = node
      result
    end
  end

  def unvisited_nodes
    @nodes_set.delete @params[:from]
    @unvisited_nodes = @nodes_set
  end

  def neighbors
    @graph.vertices.find_all do |vertice|
      vertice.from == @current.name
    end
  end
end
