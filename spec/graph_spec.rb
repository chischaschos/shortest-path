require 'spec_helper'

describe Graph do
  it 'should be able to add nodes' do
    expect(subject.add_node '1').to be true
    expect(subject.add_node '2').to be true
    expect(subject.add_node '3').to be true
  end

  it 'should be able to create edges' do
    expect(subject.add_node '1').to be true
    expect(subject.add_node '2').to be true
    expect(subject.connect '1', '2', value: 20).to be_true
    expect(subject.nodes).to have(2).items
    expect(subject.edges).to have(1).item
  end
end
