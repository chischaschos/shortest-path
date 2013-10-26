class GraphParser
  attr_reader :errors

  def initialize
    @errors = []
  end

  def read line
    if line =~ /create\s*/
      create_graph

    elsif line =~ /^node\s(\w+)/
      add_node $~

    elsif line =~ /^edge\s(\w+)\s(\w+)\s(\w+)/
      add_edge $~

    elsif line =~ /^path\s(\w+)\s(\w+)/
      calculate_path $~

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

  def add_edge match
    if !@graph
      errors << 'Try adding a graph first... try: create'
    elsif @graph.nodes.empty?
      errors << 'Try adding nodes first... try: node xyz'
    else
      @graph.connect match[1], match[2], value: match[3].to_i
    end
  end

  def calculate_path match
    finder = ShortestPath.new(@graph, from: match[1], to: match[2]).find
    print "#{finder.value} -> #{finder.string}"
  end
end
