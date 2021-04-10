function [adjacency,weightedAdjacency,incidence] = AddNode(adjacency,weightedAdjacency,incidence)
  adjacency(end+1, end+1) = 0;
  weightedAdjacency(end+1, end+1) = 0;
  incidence(end+1,1) = 0
endfunction


