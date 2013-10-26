class GraphParser
  attr_reader :errors

  def initialize
    @errors = []
  end

  def read line
    if line =~ /create/
      create_graph
    elsif line =~ /node\s(\w+)/
      add_node $~
    else
      errors << 'Me no speak inglish'
    end
  end

  def result
    @graph
  end

  private

  def create_graph
    if @graph
      errors << 'graph already created'
    else
      @graph = Graph.new
    end
  end

  def add_node match
    if @graph
      @graph.add_node match[1]
    else
      errors << 'Try adding a graph first... try: create'
    end
  end
end
