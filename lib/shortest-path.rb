require 'notifier'
require 'graph_parser'
require 'edge'
require 'node'
require 'graph'
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
      v = edge(node, @current)
      continue unless v
      sum = v.value + current.value
      node.value = sum if node.value == :infinity || sum < node.value
    end

    @current.state = :visited
  end

  def step
    @current = closest_neighbour
    current.state = :current
    save_path
    finished?
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

  def closest_neighbour
    neighbours.sort_by do |name, node|
      node.value
    end.first.last
  end

  def save_path
    @path << current.name
  end

  def neighbours
    unvisited_nodes.find_all { |name, node| edge node, @current }
  end

  def edge nodea, nodeb
    @graph.edges.find do |edge|
      (edge.to == nodea.name && edge.from == nodeb.name) ||
        (edge.to == nodeb.name && edge.from == nodea.name)
    end
  end

  def finished?
    current.name == @params[:to]
  end

end
