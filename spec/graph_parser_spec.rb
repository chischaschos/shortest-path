require 'spec_helper'

describe GraphParser do
  let(:output) { StringIO.new }

  before do
    $stdout = output
  end

  it 'creates an empty graph' do
    subject.read 'create'
    expect(subject.result).to eq Graph.new
    expect(subject.errors).to eq []
    subject.read 'create'
    expect(subject.errors).to eq ['graph already created']
    expect(subject.result).to eq Graph.new
  end

  it 'should add an error when it does not understand the command' do
    subject.read 'TPM!'
    expect(subject.errors).to eq ['Me no speak inglish']
  end

  it 'adds nodes' do
    subject.read 'create'

    subject.read 'node 1'
    subject.read 'node a_node'
    expect(subject.errors).to eq []

    graph = Graph.new
    graph.add_node '1'
    graph.add_node 'a_node'
    expect(subject.result).to eq graph
  end

  it 'adds an error when no graph is created an you try to add a node' do
    subject.read 'node a_node'
    expect(subject.result).to be_nil
    expect(subject.errors).to eq ['Try adding a graph first... try: create']
  end

  it 'should add errors when adding edges without a graph' do
    subject.read 'edge a_node 1 90'
    expect(subject.errors).to eq ['Try adding a graph first... try: create']
  end

  it 'should add errors when adding edges without nodes' do
    subject.read 'create'
    subject.read 'edge a_node 1 90'
    expect(subject.errors).to eq ['Try adding nodes first... try: node xyz']
  end

  it 'should add edges' do
    subject.read 'create'
    subject.read 'node a_node'
    subject.read 'node 1'
    subject.read 'edge a_node 1 90'
    expect(subject.errors).to eq []

    graph = Graph.new
    graph.add_node 'a_node'
    graph.add_node '1'
    graph.connect '1', 'a_node', value: 90
    expect(subject.result).to eq graph
  end

  it 'should find the shortest path' do
    subject.read 'create'
    subject.read 'node 1'
    subject.read 'node 2'
    subject.read 'node 3'
    subject.read 'node 4'
    subject.read 'node 5'
    subject.read 'node 6'
    subject.read 'edge 1 2 7'
    subject.read 'edge 1 6 14'
    subject.read 'edge 1 3 9'
    subject.read 'edge 2 3 10'
    subject.read 'edge 2 4 15'
    subject.read 'edge 4 3 11'
    subject.read 'edge 4 5 6'
    subject.read 'edge 5 6 9'
    subject.read 'edge 6 3 2'
    subject.read 'ahi va un gato corriendo como loco'
    expect(subject.errors).to eq ['Me no speak inglish']
    subject.read 'path 1 5'
    expect(output.string).to eq '20 -> 1,2,3,6,5'
  end

end
