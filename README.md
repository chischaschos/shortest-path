= Graph Parser

Clone the project and then:

    bundle install
    ➜  shortest-path git:(master) ✗ bin/gp

    ========= Welcome to the magic graph analyzer that does almost... Nothing ======
    ========= Press ctr-c to exit ======
    --> you say: ^[[A
    -->graph_parser says: Me no speak inglish
    --> you say: a
    -->graph_parser says: Me no speak inglish
    --> you say: node 1
    -->graph_parser says: Try adding a graph first... try: create
    --> you say: create
    -->graph_parser says: Graph object created
    --> you say: node 1
    -->graph_parser says: Node object created
    --> you say: node 2
    -->graph_parser says: Node object created
    --> you say: node 3
    -->graph_parser says: Node object created
    --> you say: node 4
    -->graph_parser says: Node object created
    --> you say: node 5
    -->graph_parser says: Node object created
    --> you say: node 6
    -->graph_parser says: Node object created
    --> you say: edge 1 2 7
    -->graph_parser says: Edge object created
    --> you say: edge 1 6 14
    -->graph_parser says: Edge object created
    --> you say: edge 1 3 9
    -->graph_parser says: Edge object created
    --> you say: edge 2 3 10
    -->graph_parser says: Edge object created
    --> you say: edge 2 4 15
    -->graph_parser says: Edge object created
    --> you say: edge 4 3 11
    -->graph_parser says: Edge object created
    --> you say: edge 4 5 6
    -->graph_parser says: Edge object created
    --> you say: edge 5 6 9
    -->graph_parser says: Edge object created
    --> you say: edge 6 3 2
    -->graph_parser says: Edge object created
    --> you say: path 1 5
    -->graph_parser says: 20 -> 1,2,3,6,5
    --> you say: path 1 4
    -->graph_parser says: 20 -> 1,2,3,6,5,4
    --> you say: path 1 2
    -->graph_parser says: 7 -> 1,2
    --> you say: ^CSomething killed me bye!

== For a cleaner algorithm implementation check

https://gist.github.com/chischaschos/7223804


