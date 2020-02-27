#!/usr/bin/env python3

# Copyright 2019 Mike Bergmann, mike@mdb977.de
# Released under the MIT License 

import argparse
import sys
import networkx as nx
from networkx.drawing.nx_agraph import graphviz_layout
import matplotlib.pyplot as plt

def main():
	parser = argparse.ArgumentParser()
	parser.add_argument('dependencyfile', help='dependency graphml file')
	args = parser.parse_args()

	path = args.dependencyfile

	try:
		graph = nx.read_graphml(path)
		pos = graphviz_layout(graph, prog='dot')
		nx.draw(graph, pos, with_labels=True)
		plt.show()
		return 0

	except Exception as ex:
		sys.stderr.write('ERROR: ' + str(ex) + '\n')
		return 1

if __name__ == "__main__":
	sys.exit(main())
