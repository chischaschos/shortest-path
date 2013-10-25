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

  it 'should find the shortest path from 1 to 5' do
    path = ShortestPath.find graph, from: '1', to: '5'
    expect(path.value).to eq 20
    expect(path.string).to eq '1,3,6,5'
  end

  it 'should find the shortest path from 5 to 2' do
    path = ShortestPath.find graph, from: '1', to: '4'
    expect(path.value).to eq 21
    expect(path.string).to eq '5,6,3,2'
  end

end
