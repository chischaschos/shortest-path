class GraphParser

  attr_reader :graph

  def initialize
    @notifier = Notifier.new
  end

  def read(line)
    if line =~ /create\s*/
      create_graph

    elsif line =~ /^node\s(\w+)/
      add_node Regexp.last_match

    elsif line =~ /^edge\s(\w+)\s(\w+)\s(\w+)/
      add_edge Regexp.last_match

    elsif line =~ /^path\s(\w+)\s(\w+)/
      calculate_path Regexp.last_match

    else
      @notifier << :what?
    end
  end

  def result
    @graph
  end

  def errors
    @notifier.messages
  end

  private

  def create_graph
    if @graph
      @notifier << :graph_already_created
    else
      @graph = Graph.new
      @notifier << :graph_created
    end
  end

  def add_node(match)
    if @graph
      @graph.add_node match[1]
      @notifier << :node_created
    else
      @notifier << :no_graph
    end
  end

  def add_edge(match)
    if !@graph
      @notifier << :no_graph
    elsif @graph.nodes.empty?
      @notifier << :no_nodes
    else
      @graph.connect match[1], match[2], value: match[3].to_i
      @notifier << :edge_created
    end
  end

  def calculate_path(match)
    finder = ShortestPath.new(@graph, from: match[1], to: match[2]).find
    puts "-->graph_parser says: #{finder.value} -> #{finder.string}"
  end
end
