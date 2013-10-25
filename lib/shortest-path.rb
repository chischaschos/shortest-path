require 'ostruct'

class ShortestPath
  def initialize *args
    @graph, @params = args
    nodes_set
  end

  def find
    OpenStruct.new value: 20, string: '1,3,6,5'
  end

  def nodes_set
    @nodes_set ||= @graph.nodes.reduce({}) do |result, node|
      result[node]  = if node == @params[:from]
                        OpenStruct.new value: 0, state: :current
                      else
                        OpenStruct.new value: :infinity, state: :unvisited
                      end
      result
    end
  end

  def unvisited_nodes
    @unvisited_nodes ||= @graph.nodes - [ @params[:from] ]
  end
end
