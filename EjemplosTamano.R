library(igraph)
library(tidyverse)

setwd(dir = "~/GITS/VeranoMatematicas2020/")
my_densities = seq(0.05, 0.95, by = 0.05)
names(my_densities) = my_densities


my_analysis <-
lapply(X = my_densities, FUN = function(i){
  set.seed(725)
  g = igraph::random.graph.game(n = 100, 
                            p.or.m = i, 
                            type = "gnp", 
                            directed = F, 
                            loops = F)
  
  temp = tempfile()
  
  get.adjacency(g, sparse = F) %>% write.csv(file = temp)
  size_adjacency  = file.info(temp)$size
  
  get.data.frame(g) %>% write.csv(file = temp)
  size_edgelist  = file.info(temp)$size
  
  write.graph(g, temp, "graphml")
  size_graphml  = file.info(temp)$size
  
  unlink(temp)
  rm(temp)
  
  data.frame(adjacency = size_adjacency, 
       edgelist  = size_edgelist,
       graphml   = size_graphml
       )
}) %>% bind_rows(.id = "linkProb")



my_analysis %>% 
  pivot_longer(cols = -linkProb) %>% 
  group_by(name) %>% 
  ggplot(mapping = aes(linkProb, value, colour = as.factor(name), group = name)) + 
  geom_line() +
  guides(colour=guide_legend(title="Formato de archivo")) + 
  theme_minimal() + 
  ylab("tamaño en disco (bytes)") + 
  xlab("probabilidad de enlace")



set.seed(725)
g = igraph::random.graph.game(n = 100, 
                              p.or.m = 0.1, 
                              type = "gnp", 
                              directed = F, 
                              loops = F)

V(g)$name = c(letters[1:26], paste0("node_", 27:100))

get.adjacency(g, sparse = F)[1:10, 1:10]

get.data.frame(g) %>% head(10)
write.graph(graph = g, file = "ejemplo.graphml", "graphml")
