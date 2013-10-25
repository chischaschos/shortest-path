require 'spec_helper'

describe Node do

  specify do
    node = Node.new 'A'
    node.value = 10
    node.state = :none
  end

end
