el_camino = "https://raw.githubusercontent.com/guillermodeandajauregui/useR2019INMEGEN/master/movies.csv"

vroom::vroom(el_camino) %>% 
  igraph::graph_from_data_frame() %>% 
  tidygraph::as_tbl_graph() %>% 
  ggraph::ggraph() + 
  ggraph::geom_edge_link() + 
  ggraph::geom_node_point() + 
  ggraph::geom_node_text(aes(label=name), angle = 90)
