#!/usr/bin/env python3

import sys
import networkx as nx

def generate_graph():
	graph = nx.DiGraph()
	graph.add_node('Node1')
	graph.add_node('Node2')
	graph.add_node('Node3')
	graph.add_node('Node4')
	graph.add_edge('Node1', 'Node2')
	graph.add_edge('Node1', 'Node3')
	graph.add_edge('Node2', 'Node4')
	graph.add_edge('Node3', 'Node4')
	return graph

def main():
	try:
		graph = generate_graph()
		nx.write_graphml(graph, 'dependency.graphml')
		return 0

	except Exception as ex:
		sys.stderr.write('ERROR: ' + str(ex) + '\n')
		return 1

if __name__ == "__main__":
	sys.exit(main())
