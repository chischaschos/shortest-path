require 'spec_helper'

describe Vertice do
  let(:node1) { :some }
  let(:node2) { :other }

  specify do
    vertice = Vertice.new from: node1, to: node2, value: 10
    expect(vertice.from).to eq node1
    expect(vertice.to).to eq node2
    expect(vertice.value).to eq 10
  end
end
