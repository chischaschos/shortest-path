require 'ostruct'

class ShortestPath
  attr_reader :current

  def initialize *args
    @graph, @params = args
    nodes_set
    @path = [@params[:from]]
  end

  def calculate_distances
    neighbours.each do |name, node|
      if v = vertice(node, @current)
        sum = v.value + current.value
        node.value = sum if node.value == :infinity || sum < node.value
      end
    end

    @current.state = :visited
  end

  def step
    closest = neighbours.sort_by do |name, node|
      node.value
    end.first.last
    closest.state = :current
    @current = closest
    @path << current.name
    @current.name == @params[:to]
  end

  def find
    begin
      calculate_distances
    end while not step
    OpenStruct.new value: current.value, string: @path.join(',')
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
    nodes_set.select { |name, node| node.state == :unvisited }
  end

  private

  def neighbours
    unvisited_nodes.find_all { |name, node| vertice node, @current }
  end

  def vertice nodea, nodeb
    @graph.vertices.find do |vertice|
      (vertice.to == nodea.name && vertice.from == nodeb.name) ||
        (vertice.to == nodeb.name && vertice.from == nodea.name)
    end
  end

end
