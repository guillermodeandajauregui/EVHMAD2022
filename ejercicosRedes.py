import networkx as nx

mi_path = "mi/path"

g = nx.read_graphml(mi_path)

g

len(g.nodes())
len(g.edges())

nx.draw(g)

nx.number_connected_components(g)
nx.connected_components(g)


nx.diameter(g)

g.nodes(data=True)
g.nodes(data=True)

import pandas as pd

pd.DataFrame.from_dict(dict(g.nodes(data=True)), orient='index')

g.nodes(data=True)["label"]

my_labels = nx.get_node_attributes(g, "label")
nx.set_node_attributes(g, values=my_labels, name="name")

nx.betweenness_centrality(g)

nx.edge_betweenness(g)

