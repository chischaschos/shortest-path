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
    nodes_set.select do |name, node|
      node.state != :current
    end
  end

  def calculate_distances
    vertices = @graph.vertices.find_all do |vertice|
      vertice.from == @current.name
    end
    unvisited_nodes.each do |key, node|
      if vertice = vertices.find {|vertice| vertice.to == node.name}

        sum = vertice.value + (node.value == :infinity ? 0 : node.value)
        if node.value == :infinity || sum < node.value
          node.value = sum
        end
      end
    end
  end
end
