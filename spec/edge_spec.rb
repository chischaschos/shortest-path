require 'spec_helper'

describe Edge do
  let(:node1) { :some }
  let(:node2) { :other }

  specify do
    edge = Edge.new from: node1, to: node2, value: 10
    expect(edge.from).to eq node1
    expect(edge.to).to eq node2
    expect(edge.value).to eq 10
  end
end
