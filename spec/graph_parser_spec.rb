require 'spec_helper'

describe GraphParser do
  it 'creates an empty graph' do
    parser = GraphParser.new
    parser.read 'create'
    expect(parser.result).to eq Graph.new
    expect(parser.errors).to eq []
    parser.read 'create'
    expect(parser.errors).to eq ['graph already created']
    expect(parser.result).to eq Graph.new
  end

  it 'should add an error when it does not understand the command' do
    parser = GraphParser.new
    parser.read 'TPM!'
    expect(parser.errors).to eq ['Me no speak inglish']
  end

  it 'adds nodes' do
    parser = GraphParser.new
    parser.read 'create'

    parser.read 'node 1'
    parser.read 'node a_node'
    expect(parser.errors).to eq []

    graph = Graph.new
    graph.add_node '1'
    graph.add_node 'a_node'
    expect(parser.result).to eq graph
  end

  it 'adds an error when no graph is created an you try to add a node' do
    parser = GraphParser.new
    parser.read 'node a_node'
    expect(parser.result).to be_nil
    expect(parser.errors).to eq ['Try adding a graph first... try: create']
  end

  it 'should add edges' do

  end
end
