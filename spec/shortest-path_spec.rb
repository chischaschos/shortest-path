require 'spec_helper'

describe ShortestPath do
  let(:graph) do
    graph = Graph.new
    graph.add_node '1'
    graph.add_node '2'
    graph.add_node '3'
    graph.add_node '4'
    graph.add_node '5'
    graph.add_node '6'

    graph.connect '1', '2', value: 7
    graph.connect '1', '6', value: 14
    graph.connect '1', '3', value: 9
    graph.connect '1', '2', value: 7

    graph.connect '2', '3', value: 10
    graph.connect '2', '4', value: 15

    graph.connect '4', '3', value: 11
    graph.connect '4', '5', value: 6

    graph.connect '5', '6', value: 9

    graph.connect '6', '3', value: 2
    graph
  end

  specify do
    ShortestPath.find graph
  end

end
