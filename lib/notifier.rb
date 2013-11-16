class Notifier

  attr_reader :messages

  def initialize
    @messages = []
  end

  def <<(msg)
    messages << msg
    puts "-->graph_parser says: #{translation messages.last}"
  end

  def translation(msg)
    {
      what?: 'Me no speak inglish',
      graph_already_created: 'graph already created',
      no_graph: 'Try adding a graph first... try: create',
      no_nodes: 'Try adding nodes first... try: node xyz',
      graph_created: 'Graph object created',
      node_created: 'Node object created',
      edge_created: 'Edge object created'

    }[msg]
  end
end
