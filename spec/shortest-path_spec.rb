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

    graph.connect '2', '3', value: 10
    graph.connect '2', '4', value: 15

    graph.connect '4', '3', value: 11
    graph.connect '4', '5', value: 6

    graph.connect '5', '6', value: 9

    graph.connect '6', '3', value: 2
    graph
  end

  it 'should find the shortest path from 1 to 5' do
    path = ShortestPath.new(graph, from: '1', to: '5').find
    expect(path.value).to eq 20
    expect(path.string).to eq '1,3,6,5'
  end

  it 'should find the shortest path from 5 to 2' do
    path = ShortestPath.new(graph, from: '1', to: '4').find
    expect(path.value).to eq 21
    expect(path.string).to eq '5,6,3,2'
  end

  it 'should initialize a nodes set' do
    nodes = ShortestPath.new(graph, from: '1', to: '5').nodes_set
    expect(nodes['1'].value).to eq 0
    expect(nodes['1'].state).to eq :current

    expect(nodes['2'].value).to eq :infinity
    expect(nodes['2'].state).to eq :unvisited

    expect(nodes['3'].value).to eq :infinity
    expect(nodes['3'].state).to eq :unvisited

    expect(nodes['4'].value).to eq :infinity
    expect(nodes['4'].state).to eq :unvisited

    expect(nodes['5'].value).to eq :infinity
    expect(nodes['5'].state).to eq :unvisited

    expect(nodes['6'].value).to eq :infinity
    expect(nodes['6'].state).to eq :unvisited
  end

  it 'should have a set of unvisited nodes' do
    nodes = ShortestPath.new(graph, from: '1', to: '5').unvisited_nodes
    expect(nodes.keys).to eq ['2', '3', '4', '5', '6']
  end

  it 'should calculate the unvisited neighbors' do
    finder = ShortestPath.new graph, from: '1', to: '5'
    expect(finder.current).to eq Node.new '1'

    finder.calculate_distances

    distances = finder.nodes_set.map do |key, node|
      { node.name => node.value }
    end

    expect(distances).to eq [
      {"1"=>0},
      {"2"=>7},
      {"3"=>9},
      {"4"=>:infinity},
      {"5"=>:infinity},
      {"6"=>14}]
  end

  it 'should remove a visited node after caclulating distances' do
    finder = ShortestPath.new graph, from: '1', to: '5'
    finder.calculate_distances
    expect(finder.unvisited_nodes.keys).to eq ['2', '3', '4', '5', '6']
    expect(finder.current.state).to eq :visited
  end

  it 'should mark the closest node as current' do
    finder = ShortestPath.new graph, from: '1', to: '5'
    finder.calculate_distances
    finder.step
    expect(finder.current.name).to eq '2'
    expect(finder.current.value).to eq 7
    expect(finder.unvisited_nodes.keys).to eq ['3', '4', '5', '6']
  end

  it 'should find the path in 3 steps' do
    finder = ShortestPath.new graph, from: '1', to: '5'

    expect(finder.current.name).to eq '1'
    expect(finder.current.value).to eq 0
    expect(finder.unvisited_nodes.keys).to eq ['2', '3', '4', '5', '6']
    finder.calculate_distances
    expect(finder.step).to be_false
    expect(finder.nodes_set.map do |key, node|
      { node.name => node.value }
    end).to eq [
      {"1"=>0},
      {"2"=>7},
      {"3"=>9},
      {"4"=>:infinity},
      {"5"=>:infinity},
      {"6"=>14}]

    expect(finder.current.name).to eq '2'
    expect(finder.current.value).to eq 7
    expect(finder.unvisited_nodes.keys).to eq ['3', '4', '5', '6']
    finder.calculate_distances
    expect(finder.step).to be_false
    expect(finder.nodes_set.map do |key, node|
      { node.name => node.value }
    end).to eq [
      {"1"=>0},
      {"2"=>7},
      {"3"=>9},
      {"4"=>15},
      {"5"=>:infinity},
      {"6"=>14}]

    expect(finder.current.name).to eq '3'
    expect(finder.current.value).to eq 9
    expect(finder.unvisited_nodes.keys).to eq ['4', '5', '6']
    finder.calculate_distances
    expect(finder.step).to be_false
    expect(finder.nodes_set.map do |key, node|
      { node.name => node.value }
    end).to eq [
      {"1"=>0},
      {"2"=>7},
      {"3"=>9},
      {"4"=>15},
      {"5"=>:infinity},
      {"6"=>14}]

    expect(finder.current.name).to eq '6'
    #expect(finder.current.value).to eq 2
    expect(finder.unvisited_nodes.keys).to eq ['4', '5']
    finder.calculate_distances
    expect(finder.step).to be_true
    expect(finder.nodes_set.map do |key, node|
      { node.name => node.value }
    end).to eq [
      {"1"=>0},
      {"2"=>7},
      {"3"=>9},
      {"4"=>15},
      {"5"=>9},
      {"6"=>14}]

    expect(finder.current.name).to eq '5'
    #expect(finder.current.value).to eq 2
  end

end
